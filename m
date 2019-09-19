Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8959BB7E11
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbfISPWb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 11:22:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51481 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389444AbfISPWb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 11:22:31 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1iAyGM-0003qL-Ei
        for dmaengine@vger.kernel.org; Thu, 19 Sep 2019 17:22:30 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1iAyGM-0001GZ-3v
        for dmaengine@vger.kernel.org; Thu, 19 Sep 2019 17:22:30 +0200
Message-ID: <ad87f175496358adb825240f1de609318ed8204c.camel@pengutronix.de>
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     fugang.duan@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        dan.j.williams@intel.com, yibin.gong@nxp.com, shawnguo@kernel.org,
        dmaengine@vger.kernel.or, linux-arm-kernel@lists.infradead.org,
        l.stach@pengutronix.de
In-Reply-To: <20190919142942.12469-3-philipp.puschmann@emlix.com>
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
         <20190919142942.12469-3-philipp.puschmann@emlix.com>
Content-Type: multipart/mixed; boundary="=-sqfX9QZyaTnBJ7ZxOgmw"
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] dmaengine: imx-sdma: fix dma freezes
Date:   Thu, 19 Sep 2019 17:22:29 +0200
Content-Transfer-Encoding: 
User-Agent: Evolution 3.30.5-1.1 
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--=-sqfX9QZyaTnBJ7ZxOgmw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

see below...

On Thu, 2019-09-19 at 16:29 +0200, Philipp Puschmann wrote:
> For some years and since many kernel versions there are reports that the
> RX UART SDMA channel stops working at some point. The workaround was to
> disable DMA for RX. This commit tries to fix the problem itself.
>=20
> Due to its license i wasn't able to debug the sdma script itself but it
> somehow leads to blocking the scheduling of the channel script when a
> running sdma script does not find any free descriptor in the ring to put
> its data into.
>=20
> If we detect such a potential case we manually restart the channel.
>=20
> As sdmac->desc is constant we can move desc out of the loop.
>=20
> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>=20
> Changelog v4:
>  - fixed the fixes tag
> =20
> Changelog v3:
>  - use correct dma_wmb() instead of dma_wb()
>  - add fixes tag
> =20
> Changelog v2:
>  - clarify comment and commit description
>=20
>  drivers/dma/imx-sdma.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index e029a2443cfc..a32b5962630e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sd=
mac)
>  static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>  {
>  	struct sdma_buffer_descriptor *bd;
> -	int error =3D 0;
> -	enum dma_status	old_status =3D sdmac->status;
> +	struct sdma_desc *desc =3D sdmac->desc;
> +	int error =3D 0, cnt =3D 0;
> +	enum dma_status old_status =3D sdmac->status;
> =20
>  	/*
>  	 * loop mode. Iterate over descriptors, re-setup them and
>  	 * call callback function.
>  	 */
> -	while (sdmac->desc) {
> -		struct sdma_desc *desc =3D sdmac->desc;
> +	while (desc) {
> =20
>  		bd =3D &desc->bd[desc->buf_tail];
> =20
>  		if (bd->mode.status & BD_DONE)
>  			break;
> =20
> +		cnt++;
> +
>  		if (bd->mode.status & BD_RROR) {
>  			bd->mode.status &=3D ~BD_RROR;
>  			sdmac->status =3D DMA_ERROR;
> @@ -822,6 +824,17 @@ static void sdma_update_channel_loop(struct sdma_cha=
nnel *sdmac)
>  		if (error)
>  			sdmac->status =3D old_status;
>  	}
> +
> +	/* In some situations it may happen that the sdma does not found any
                                                          ^ hasn't
> +	 * usable descriptor in the ring to put data into. The channel is
> +	 * stopped then. While there is no specific error condition we can
> +	 * check for, a necessary condition is that all available buffers for
> +	 * the current channel have been written to by the sdma script. In
> +	 * this case and after we have made the buffers available again,
> +	 * we restart the channel.
> +	 */

Are you sure we can't miss cases where we only had to make some buffers
available again, but the SDMA already ran out of buffers before?

A while ago, I was debugging a similar issue triggered by receiving
data with a wrong baud rate, which leads to all descriptors being
marked with the error flag very quickly (and the SDMA stalling).
I noticed that you can check if the channel is still running by
checking the SDMA_H_STATSTOP register & BIT(sdmac->channel).

I also added a flag for the sdmac->flags field to allow stopping the
channel from the callback (otherwise it would enable the channel
again).

Attached is my current version of that patch for reference.

> +	if (cnt >=3D desc->num_bd)
> +		sdma_enable_channel(sdmac->sdma, sdmac->channel);
>  }
> =20
>  static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
=0D
--=-sqfX9QZyaTnBJ7ZxOgmw
Content-Disposition: attachment;
	filename*0=0001-dmaengine-imx-sdma-restart-stopped-cyclic-transfers.patc;
	filename*1=h
Content-Type: text/x-patch;
	name="0001-dmaengine-imx-sdma-restart-stopped-cyclic-transfers.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA3M2Q3ZGNmODRkYWM1NTEyYzUwNDQ4ZmY2YWRmMDg0ZjFhOWJkNmY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW4gTHVlYmJlIDxqbHVAcGVuZ3V0cm9uaXguZGU+CkRhdGU6
IFR1ZSwgMTYgQXByIDIwMTkgMTg6MzU6MDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBkbWFlbmdp
bmU6IGlteC1zZG1hOiByZXN0YXJ0IHN0b3BwZWQgY3ljbGljIHRyYW5zZmVycwoKRm9yIGN5Y2xp
YyBETUEgdHJhbnNmZXJzLCB3ZSBoYXZlIGF0IGxlYXN0IHR3byBjYXNlcyB3aGVyZSB3ZSBjYW4g
cnVuCm91dCBkZXNjcmlwdG9ycyBhdmFpbGFibGUgdG8gdGhlIGVuZ2luZToKLSBJbnRlcnJ1cHMg
YXJlIGRpc2FibGVkIGZvciB0b28gbG9uZyBhbmQgYWxsIGJ1ZmZlcnMgYSBmaWxsZWQgd2l0aAog
IGRhdGEuCi0gRE1BIGVycm9ycyAoc3VjaCBhcyBnZW5lcmF0ZWQgYnkgYmF1ZCByYXRlIG1pc21h
dGNoIHdpdGggaW14LXVhcnQpIHVzZQogIHVwIGFsbCBkZXNjcmlwdG9ycyBiZWZvcmUgd2UgY2Fu
IHJlYWN0LgoKSW4gdGhpcyBjYXNlLCBTRE1BIHN0b3BzIHRoZSBjaGFubmVsIGFuZCBubyBmdXJ0
aGVyIHRyYW5zZmVycyBhcmUgZG9uZQp1bnRpbCB0aGUgcmVzcGVjdGl2ZSBjaGFubmVsIGlzIGRp
c2FibGVkIGFuZCByZS1lbmFibGVkLgoKVGhlIGJlc3Qgd2UgY2FuIGRvIGluIHRoaXMgY2FzZSBp
cyB0byBjaGVjayBpZiB0aGUgdHJhbnNmZXIgc2hvdWxkIHN0aWxsCmJlIGVuYWJsZWQgKGl0IGNv
dWxkIGhhdmUgYmVlbiBkaXNhYmxlZCBkdXJpbmcKc2RtYV91cGRhdGVfY2hhbm5lbF9sb29wKSwg
YnV0IHRoZSBTRE1BIGNoYW5uZWwgaXMgc3RvcHBlZC4gSW4gdGhpcwpjYXNlLCB3ZSByZS1zdGFy
dCB0aGUgY2hhbm5lbC4KClRvIGF2b2lkIHJhY2luZyB3aXRoIGNoYW5nZXMgdG8gdGhlIHNkbWFj
LT5zdGF0dXMgZmllbGQgKHdoaWNoIGlzCndyaXR0ZW4gYW5kIHJlc3RvcmVkIGluIHNkbWFfdXBk
YXRlX2NoYW5uZWxfbG9vcCksIHdlIGFkZCBhIG5ldyBmbGFnCihJTVhfRE1BX0FDVElWRSkgdG8g
aW5kaWNhdGUgdGhhdCB0aGUgY2hhbm5lbCBpcyBjdXJyZW50bHkgYWN0aXZlLgoKU2lnbmVkLW9m
Zi1ieTogSmFuIEx1ZWJiZSA8amx1QHBlbmd1dHJvbml4LmRlPgotLS0KIGRyaXZlcnMvZG1hL2lt
eC1zZG1hLmMgfCAxMyArKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9p
bXgtc2RtYS5jCmluZGV4IDU4ZmE4NTIwODkyYi4uODc3NDI1OWFmMjRjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2RtYS9pbXgtc2RtYS5jCisrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMKQEAgLTM4
Myw2ICszODMsNyBAQCBzdHJ1Y3Qgc2RtYV9jaGFubmVsIHsKIH07CiAKICNkZWZpbmUgSU1YX0RN
QV9TR19MT09QCQlCSVQoMCkKKyNkZWZpbmUgSU1YX0RNQV9BQ1RJVkUJCUJJVCgxKQogCiAjZGVm
aW5lIE1BWF9ETUFfQ0hBTk5FTFMgMzIKICNkZWZpbmUgTVhDX1NETUFfREVGQVVMVF9QUklPUklU
WSAxCkBAIC02NTgsNiArNjU5LDkgQEAgc3RhdGljIGludCBzZG1hX2NvbmZpZ19vd25lcnNoaXAo
c3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsCiAKIHN0YXRpYyB2b2lkIHNkbWFfZW5hYmxlX2No
YW5uZWwoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hLCBpbnQgY2hhbm5lbCkKIHsKKwlzdHJ1Y3Qg
c2RtYV9jaGFubmVsICpzZG1hYyA9ICZzZG1hLT5jaGFubmVsW2NoYW5uZWxdOworCisJc2RtYWMt
PmZsYWdzIHw9IElNWF9ETUFfQUNUSVZFOwogCXdyaXRlbChCSVQoY2hhbm5lbCksIHNkbWEtPnJl
Z3MgKyBTRE1BX0hfU1RBUlQpOwogfQogCkBAIC03NzQsNiArNzc4LDcgQEAgc3RhdGljIHZvaWQg
c2RtYV9zdGFydF9kZXNjKHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQogCiBzdGF0aWMgdm9p
ZCBzZG1hX3VwZGF0ZV9jaGFubmVsX2xvb3Aoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMpCiB7
CisJc3RydWN0IHNkbWFfZW5naW5lICpzZG1hID0gc2RtYWMtPnNkbWE7CiAJc3RydWN0IHNkbWFf
YnVmZmVyX2Rlc2NyaXB0b3IgKmJkOwogCWludCBlcnJvciA9IDA7CiAJZW51bSBkbWFfc3RhdHVz
CW9sZF9zdGF0dXMgPSBzZG1hYy0+c3RhdHVzOwpAQCAtODIwLDYgKzgyNSwxMyBAQCBzdGF0aWMg
dm9pZCBzZG1hX3VwZGF0ZV9jaGFubmVsX2xvb3Aoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMp
CiAJCWlmIChlcnJvcikKIAkJCXNkbWFjLT5zdGF0dXMgPSBvbGRfc3RhdHVzOwogCX0KKworCWlm
ICgoc2RtYWMtPmZsYWdzICYgSU1YX0RNQV9BQ1RJVkUpICYmCisJICAgICEocmVhZGxfcmVsYXhl
ZChzZG1hLT5yZWdzICsgU0RNQV9IX1NUQVRTVE9QKSAmIEJJVChzZG1hYy0+Y2hhbm5lbCkpKSB7
CisJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoc2RtYS0+ZGV2LCAiU0RNQSBjaGFubmVsICVkOiBjeWNs
aWMgdHJhbnNmZXIgZGlzYWJsZWQgYnkgSFcsIHJlZW5hYmxpbmdcbiIsCisJCQkJc2RtYWMtPmNo
YW5uZWwpOworCQl3cml0ZWwoQklUKHNkbWFjLT5jaGFubmVsKSwgc2RtYS0+cmVncyArIFNETUFf
SF9TVEFSVCk7CisJfTsKIH0KIAogc3RhdGljIHZvaWQgbXhjX3NkbWFfaGFuZGxlX2NoYW5uZWxf
bm9ybWFsKHN0cnVjdCBzZG1hX2NoYW5uZWwgKmRhdGEpCkBAIC0xMDQ5LDYgKzEwNjEsNyBAQCBz
dGF0aWMgaW50IHNkbWFfZGlzYWJsZV9jaGFubmVsKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikKIAlz
dHJ1Y3Qgc2RtYV9lbmdpbmUgKnNkbWEgPSBzZG1hYy0+c2RtYTsKIAlpbnQgY2hhbm5lbCA9IHNk
bWFjLT5jaGFubmVsOwogCisJc2RtYWMtPmZsYWdzICY9IH5JTVhfRE1BX0FDVElWRTsKIAl3cml0
ZWxfcmVsYXhlZChCSVQoY2hhbm5lbCksIHNkbWEtPnJlZ3MgKyBTRE1BX0hfU1RBVFNUT1ApOwog
CXNkbWFjLT5zdGF0dXMgPSBETUFfRVJST1I7CiAKLS0gCjIuMjMuMAoK



--=-sqfX9QZyaTnBJ7ZxOgmw--

