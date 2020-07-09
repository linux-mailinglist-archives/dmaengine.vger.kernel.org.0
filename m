Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D421A0C2
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGINY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 09:24:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34174 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGINY5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jul 2020 09:24:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 069DOrVI105999;
        Thu, 9 Jul 2020 08:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594301093;
        bh=t+JqBPxOITbYeRlj2cm2qIKr5U5ndYtTB2pZZRpkazE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wDASNlOPZSC9GUcOPio/+Qj+16r7oExOaoBilL/sBoXtQ55Vcva8/FL2oyortho6j
         7F2nMqMQH8K+bWwCaQmbSWrS1UbwfYOd1cd1PE5rd896uKXEHMz9W8zpFy4Lk+Z4xw
         0cDZUkxA+TrGZrv2DUJ7BRsuQPuyWkkMVXpMPCzM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 069DOrXJ102890
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jul 2020 08:24:53 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 9 Jul
 2020 08:24:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 9 Jul 2020 08:24:52 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069DOopm123770;
        Thu, 9 Jul 2020 08:24:51 -0500
Subject: Re: [PATCH v6 3/6] dmaengine: Add support for repeating transactions
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dmaengine@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-4-laurent.pinchart@ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <ca31a002-872f-b887-cf47-eac9130483a2@ti.com>
Date:   Thu, 9 Jul 2020 16:25:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708201906.4546-4-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 08/07/2020 23.19, Laurent Pinchart wrote:
> DMA engines used with displays perform 2D interleaved transfers to read=

> framebuffers from memory and feed the data to the display engine. As th=
e
> same framebuffer can be displayed for multiple frames, the DMA
> transactions need to be repeated until a new framebuffer replaces the
> current one. This feature is implemented natively by some DMA engines
> that have the ability to repeat transactions and switch to a new
> transaction at the end of a transfer without any race condition or fram=
e
> loss.
>=20
> This patch implements support for this feature in the DMA engine API. A=

> new DMA_PREP_REPEAT transaction flag allows DMA clients to instruct the=

> DMA channel to repeat the transaction automatically until one or more
> new transactions are issued on the channel (or until all active DMA
> transfers are explicitly terminated with the dmaengine_terminate_*()
> functions). A new DMA_REPEAT transaction type is also added for DMA
> engine drivers to report their support of the DMA_PREP_REPEAT flag.
>=20
> A new DMA_PREP_LOAD_EOT transaction flag is also introduced (with a
> corresponding DMA_LOAD_EOT capability bit), as requested during the
> review of v4. The flag instructs the DMA channel that the transaction
> being queued should replace the active repeated transaction when the
> latter terminates (at End Of Transaction). Not setting the flag will
> result in the active repeated transaction to continue being repeated,
> and the new transaction being silently ignored.
>=20
> The DMA_PREP_REPEAT flag is currently supported for interleaved
> transactions only. Its usage can easily be extended to cover more
> transaction types simply by adding an appropriate check in the
> corresponding dmaengine_prep_*() function.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v5:
>=20
> - Document the API in Documentation/driver-api/dmaengine/
> - Small improvements to documentation in header file

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Changes since v4:
>=20
> - Add DMA_LOAD_EOT and DMA_PREP_LOAD_EOT flags
> ---
>  Documentation/driver-api/dmaengine/client.rst |  4 +-
>  .../driver-api/dmaengine/provider.rst         | 49 +++++++++++++++++++=

>  include/linux/dmaengine.h                     | 17 +++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentat=
ion/driver-api/dmaengine/client.rst
> index 2104830a99ae..41938aa2bdeb 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -86,7 +86,9 @@ The details of these operations are:
>    - interleaved_dma: This is common to Slave as well as M2M clients. F=
or slave
>      address of devices' fifo could be already known to the driver.
>      Various types of operations could be expressed by setting
> -    appropriate values to the 'dma_interleaved_template' members.
> +    appropriate values to the 'dma_interleaved_template' members. Cycl=
ic
> +    interleaved DMA transfers are also possible if supported by the ch=
annel by
> +    setting the DMA_PREP_REPEAT transfer flag.
> =20
>    A non-NULL return of this transfer API represents a "descriptor" for=

>    the given transaction.
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Document=
ation/driver-api/dmaengine/provider.rst
> index 56e5833e8a07..f896acccdfee 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -239,6 +239,27 @@ Currently, the types available are:
>      want to transfer a portion of uncompressed data directly to the
>      display to print it
> =20
> +- DMA_REPEAT
> +
> +  - The device supports repeated transfers. A repeated transfer, indic=
ated by
> +    the DMA_PREP_REPEAT transfer flag, is similar to a cyclic transfer=
 in that
> +    it gets automatically repeated when it ends, but can additionally =
be
> +    replaced by the client.
> +
> +  - This feature is limited to interleaved transfers, this flag should=
 thus not
> +    be set if the DMA_INTERLEAVE flag isn't set. This limitation is ba=
sed on
> +    the current needs of DMA clients, support for additional transfer =
types
> +    should be added in the future if and when the need arises.
> +
> +- DMA_LOAD_EOT
> +
> +  - The device supports replacing repeated transfers at end of transfe=
r (EOT)
> +    by queuing a new transfer with the DMA_PREP_LOAD_EOT flag set.
> +
> +  - Support for replacing a currently running transfer at another poin=
t (such
> +    as end of burst instead of end of transfer) will be added in the f=
uture
> +    based on DMA clients needs, if and when the need arises.
> +
>  These various types will also affect how the source and destination
>  addresses change over time.
> =20
> @@ -531,6 +552,34 @@ DMA_CTRL_REUSE
>      writes for which the descriptor should be in different format from=

>      normal data descriptors.
> =20
> +- DMA_PREP_REPEAT
> +
> +  - If set, the transfer will be automatically repeated when it ends u=
ntil a
> +    new transfer is queued on the same channel with the DMA_PREP_LOAD_=
EOT flag.
> +    If the next transfer to be queued on the channel does not have the=

> +    DMA_PREP_LOAD_EOT flag set, the current transfer will be repeated =
until the
> +    client terminates all transfers.
> +
> +  - This flag is only supported if the channel reports the DMA_REPEAT
> +    capability.
> +
> +- DMA_PREP_LOAD_EOT
> +
> +  - If set, the transfer will replace the transfer currently being exe=
cuted at
> +    the end of the transfer.
> +
> +  - This is the default behaviour for non-repeated transfers, specifyi=
ng
> +    DMA_PREP_LOAD_EOT for non-repeated transfers will thus make no dif=
ference.
> +
> +  - When using repeated transfers, DMA clients will usually need to se=
t the
> +    DMA_PREP_LOAD_EOT flag on all transfers, otherwise the channel wil=
l keep
> +    repeating the last repeated transfer and ignore the new transfers =
being
> +    queued. Failure to set DMA_PREP_LOAD_EOT will appear as if the cha=
nnel was
> +    stuck on the previous transfer.
> +
> +  - This flag is only supported if the channel reports the DMA_LOAD_EO=
T
> +    capability.
> +
>  General Design Notes
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index e1c03339918f..328e3aca7f51 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -61,6 +61,8 @@ enum dma_transaction_type {
>  	DMA_SLAVE,
>  	DMA_CYCLIC,
>  	DMA_INTERLEAVE,
> +	DMA_REPEAT,
> +	DMA_LOAD_EOT,
>  /* last transaction type for creation of the capabilities mask */
>  	DMA_TX_TYPE_END,
>  };
> @@ -176,6 +178,16 @@ struct dma_interleaved_template {
>   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is c=
ommand
>   *  data and the descriptor should be in different format from normal
>   *  data descriptors.
> + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be aut=
omatically
> + *  repeated when it ends until a transaction is issued on the same ch=
annel
> + *  with the DMA_PREP_LOAD_EOT flag set. This flag is only applicable =
to
> + *  interleaved transactions and is ignored for all other transaction =
types.
> + * @DMA_PREP_LOAD_EOT: tell the driver that the transaction shall repl=
ace any
> + *  active repeated (as indicated by DMA_PREP_REPEAT) transaction when=
 the
> + *  repeated transaction ends. Not setting this flag when the previous=
ly queued
> + *  transaction is marked with DMA_PREP_REPEAT will cause the new tran=
saction
> + *  to never be processed and stay in the issued queue forever. The fl=
ag is
> + *  ignored if the previous transaction is not a repeated transaction.=

>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT =3D (1 << 0),
> @@ -186,6 +198,8 @@ enum dma_ctrl_flags {
>  	DMA_PREP_FENCE =3D (1 << 5),
>  	DMA_CTRL_REUSE =3D (1 << 6),
>  	DMA_PREP_CMD =3D (1 << 7),
> +	DMA_PREP_REPEAT =3D (1 << 8),
> +	DMA_PREP_LOAD_EOT =3D (1 << 9),
>  };
> =20
>  /**
> @@ -980,6 +994,9 @@ static inline struct dma_async_tx_descriptor *dmaen=
gine_prep_interleaved_dma(
>  {
>  	if (!chan || !chan->device || !chan->device->device_prep_interleaved_=
dma)
>  		return NULL;
> +	if (flags & DMA_PREP_REPEAT &&
> +	    !test_bit(DMA_REPEAT, chan->device->cap_mask.bits))
> +		return NULL;
> =20
>  	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
>  }
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

