Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B29B6135675
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgAIKF0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jan 2020 05:05:26 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12397 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgAIKF0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jan 2020 05:05:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e16faab0000>; Thu, 09 Jan 2020 02:04:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 02:04:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 02:04:45 -0800
Received: from localhost (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 10:04:45 +0000
Date:   Thu, 9 Jan 2020 11:04:42 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WC?= aw <mirq-linux@rere.qmqm.pl>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] NVIDIA Tegra APB DMA driver fixes and
 improvements
Message-ID: <20200109100442.GA2008067@ulmo>
References: <20200106011708.7463-1-digetx@gmail.com>
 <85d8ea335734417081399a082d44024c@HQMAIL105.nvidia.com>
 <c68cde59-0571-f58f-bf3c-8ce1cbdcc387@gmail.com>
MIME-Version: 1.0
In-Reply-To: <c68cde59-0571-f58f-bf3c-8ce1cbdcc387@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578564268; bh=h/bNY+RUGUzgoTQywuHlYt1541fd3LnuO7OyTEMGfZo=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=gX714nRpYrIKuohxrPA01ArolujnOrGF5go2h2h5RS9JWgY8VWZ5mBbgD6vSuCLMs
         /epGVKemrGPMdTI6zf7p8U85jchBhyDKOV+9iElckjf3jLB7z/MKk9Y5iAC2xl6V5U
         aYmtfi8Vh7JN7G1IWKsLOMMXsugPj9tw388It2ofdjHimZ2LC+fPcIZI2tmsb6hF8A
         x5HLX+8VcCk7lCD7bZg43A4Hyp1a8FxJGGQbtzEVWLAP9EMRQ4JpK2MSbSm17XacAZ
         YgxGzXJCsicighnq0T4OaRtZJFk93gJdrcntkxqg5ud3RdFY7HVKAvOuxEYNaBSTrD
         /G5GX2j55Ji6A==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 06:07:46PM +0300, Dmitry Osipenko wrote:
> 08.01.2020 15:51, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 06 Jan 2020 04:16:55 +0300, Dmitry Osipenko wrote:
> >> Hello,
> >>
> >> This is series fixes some problems that I spotted recently, secondly t=
he
> >> driver's code gets a cleanup. Please review and apply, thanks in advan=
ce!
> >>
> >> Changelog:
> >>
> >> v3: - In the review comment to v1 Micha=C5=82 Miros=C5=82aw suggested =
that "Prevent
> >>       race conditions on channel's freeing" does changes that deserve =
to
> >>       be separated into two patches. I factored out and improved taskl=
et
> >>       releasing into this new patch:
> >>
> >>         dmaengine: tegra-apb: Clean up tasklet releasing
> >>
> >>     - The "Fix use-after-free" patch got an improved commit message.
> >>
> >> v2: - I took another look at the driver and spotted few more things th=
at
> >>       could be improved, which resulted in these new patches:
> >>
> >>         dmaengine: tegra-apb: Remove runtime PM usage
> >>         dmaengine: tegra-apb: Clean up suspend-resume
> >>         dmaengine: tegra-apb: Add missing of_dma_controller_free
> >>         dmaengine: tegra-apb: Allow to compile as a loadable kernel mo=
dule
> >>         dmaengine: tegra-apb: Remove MODULE_ALIAS
> >>
> >> Dmitry Osipenko (13):
> >>   dmaengine: tegra-apb: Fix use-after-free
> >>   dmaengine: tegra-apb: Implement synchronization callback
> >>   dmaengine: tegra-apb: Prevent race conditions on channel's freeing
> >>   dmaengine: tegra-apb: Clean up tasklet releasing
> >>   dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
> >>   dmaengine: tegra-apb: Use devm_platform_ioremap_resource
> >>   dmaengine: tegra-apb: Use devm_request_irq
> >>   dmaengine: tegra-apb: Fix coding style problems
> >>   dmaengine: tegra-apb: Remove runtime PM usage
> >>   dmaengine: tegra-apb: Clean up suspend-resume
> >>   dmaengine: tegra-apb: Add missing of_dma_controller_free
> >>   dmaengine: tegra-apb: Allow to compile as a loadable kernel module
> >>   dmaengine: tegra-apb: Remove MODULE_ALIAS
> >>
> >>  drivers/dma/Kconfig           |   2 +-
> >>  drivers/dma/tegra20-apb-dma.c | 481 ++++++++++++++++------------------
> >>  2 files changed, 220 insertions(+), 263 deletions(-)
> >=20
> > Test results:
> >   13 builds: 13 pass, 0 fail
> >   12 boots:  11 pass, 1 fail
>=20
> I'm not sure how to interpret this result. Could you please explain what
> that fail means?

Yeah, Jon and I have been discussing about whether to expose this as
failure or not. Basically what I'm trying to do here is to provide
automated test results. The way that I'm currently doing this is to run
these patches through our internal test farm and if the tests succeed,
send out the results and reply with a Tested-by: to all patches so that
patchwork has a record of it.

So just the fact that the test results were sent means the tests passed.
I do see now that that's not at all clear, so I'm going to have to tweak
the summary a bit to clarify that.

I've also added something like this to the bottom of the summary:

	Warnings:
	- 1 failure for board tegra186-p2771-0000 but tests passed

This is supposed to indicate that the one failure that you're seeing in
the test results is an intermittent failure. Looking at the logs I see
that at some point there was an intermittent boot failure for Jetson TX2
but then the test farm rebooted the system and then it succeeded and ran
the tests successfully.

So I guess in general this means that if you get that test summary and a
list of Tested-by: replies to the patches, all is well. Unfortunately I
don't really have a useful way of reporting failure, so I'm not sending
out a summary in that case. That means you currently can't distinguish
between whether the series hasn't been tested at all or whether it
failed. Although, I have also started to use patchwork checks to track
this in patchwork, so you could look at the patches in patchwork and see
if they have been tested, and that does record success or failure.

> >   38 tests:  38 pass, 0 fail
> >=20
> > Linux version: 5.5.0-rc5-gf9d40c056c0f
> > Boards tested: tegra20-ventana, tegra30-cardhu-a04, tegra124-jetson-tk1,
> >                tegra186-p2771-0000, tegra194-p2972-0000,
> >                tegra210-p2371-2180
> >=20
>=20
> Will be awesome to see the detailed testing results, at least console
> log like it was with NVTB.

Yeah, I'm working on that. It's the only reason I'm not sending out
failure reports because it would just say that things failed without
giving you any indication about why.

Currently the plan is to upload more detailed test results to a public
location (perhaps github, like nvtb used to) and provide a link to them
in patchwork and the test summary.

Do you think that would be helpful? Anything else you think would be
useful to have in these reports? Or anything about the above that you
think is impractical for you as a contributor?

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4W+rgACgkQ3SOs138+
s6EKTA/+LyZ4UQA6CZKCZrIrsEBpSQUeit7C9mj0r5Lq+uVeccGtDuZ+RS2iIcs4
5PPQPN6K3pDSSfT6ocxHdbtwcIpM2FisaZa5bjkg2Bq2wQgzO2PpTWuz9iJG7zzZ
nTGQbgDMpgo1yXRCJF1iXg/qQ7TpkXlorHij3IC9DP/bImrr0sLHS+HXpfNXzdig
RX4hYJpJ7HQoNWbUZx/u288xRrw/9f0fJI+YAYF8159unmN4KU1kcyBH55r6dYoN
o1QHW6neIGb+IMFYm1dMFAtMJH8fK7bpx/8bH0a6iE12va1sl4eOIybM24lKFVvb
WNMl0VM1BNRO+qMlWJd5+o8IZfKE/W3fMOvkFOnnskWvYkpjTeB4+kbDb+3cNWeW
0QS+mybEw5NqX1NMxBsxTKHRT2lK1CQ67w65NB2yQrgoI17Ggdme+TpfdJdIRFqp
DEVVNetU8srqrZswZs6iMlF7yTNgXMuZq6JSM3wHV4gKl0nAdzVY35aD5zxka4hc
wmqhfPGZ7ElSlhZ1lH0q3X0hCErFy+lkux38sv/K348JFe7HLn39TpwmVK73erxD
b5APUVh3NAsuvDqdppkmw+pnqDvWuYyFDqXStgNIB45F5H9gVmdqjKXa5zpSc0Wf
s2GZ/FS979O4SRf+gG3FrhwGRik7rgnYogrGIpbPZORkI60xHpw=
=rv/G
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
