Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984E4134232
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2020 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgAHMvL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jan 2020 07:51:11 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2133 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgAHMvL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jan 2020 07:51:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e15d02c0000>; Wed, 08 Jan 2020 04:50:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jan 2020 04:51:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jan 2020 04:51:10 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 12:51:09 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 12:51:09 +0000
Received: from [192.168.22.23] (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 12:51:07 +0000
From:   Thierry Reding <treding@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82?= aw <mirq-linux@rere.qmqm.pl>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] NVIDIA Tegra APB DMA driver fixes and improvements
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Message-ID: <85d8ea335734417081399a082d44024c@HQMAIL105.nvidia.com>
Date:   Wed, 8 Jan 2020 12:51:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578487853; bh=07RgEQXvmw0hpSmELXKe3Vl/OIUylmmcauPctEl8Okg=;
        h=X-PGP-Universal:From:To:CC:Subject:In-Reply-To:References:
         X-NVConfidentiality:MIME-Version:Message-ID:Date:Content-Type:
         Content-Transfer-Encoding;
        b=sHnn9rKoZqlmS90zDg4BZOPyVAByenoUio17rRnjU6NTWcYZDxN57X68TrwR5Z9bV
         yeLilikOvtnevRg+Bj06GycMMRTb9EMPaoD5kjCwM2p8HvZ/bZIIzsiia3UtagyqId
         gMygLwcmdtgp2YXJ9805gw77QaFKn5Wc57emXQROA3bZPVzSu0yd06UXY2FWrQuQPY
         uNr+7s8TPXbrBhgeNB2vHX2kpDhAakt5D1ol69c1KwktWReXb/qKKC29scbzko00yu
         1Oi4HBXYMyXdjwndwWDNvjyobQapooQ+gur1f8MZxBe1pYayWCZbvM+MpaAum0RS34
         QZP0X6cXotLLg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 06 Jan 2020 04:16:55 +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This is series fixes some problems that I spotted recently, secondly the
> driver's code gets a cleanup. Please review and apply, thanks in advance!
>=20
> Changelog:
>=20
> v3: - In the review comment to v1 Micha=C5=82 Miros=C5=82aw suggested tha=
t "Prevent
>       race conditions on channel's freeing" does changes that deserve to
>       be separated into two patches. I factored out and improved tasklet
>       releasing into this new patch:
>=20
>         dmaengine: tegra-apb: Clean up tasklet releasing
>=20
>     - The "Fix use-after-free" patch got an improved commit message.
>=20
> v2: - I took another look at the driver and spotted few more things that
>       could be improved, which resulted in these new patches:
>=20
>         dmaengine: tegra-apb: Remove runtime PM usage
>         dmaengine: tegra-apb: Clean up suspend-resume
>         dmaengine: tegra-apb: Add missing of_dma_controller_free
>         dmaengine: tegra-apb: Allow to compile as a loadable kernel modul=
e
>         dmaengine: tegra-apb: Remove MODULE_ALIAS
>=20
> Dmitry Osipenko (13):
>   dmaengine: tegra-apb: Fix use-after-free
>   dmaengine: tegra-apb: Implement synchronization callback
>   dmaengine: tegra-apb: Prevent race conditions on channel's freeing
>   dmaengine: tegra-apb: Clean up tasklet releasing
>   dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
>   dmaengine: tegra-apb: Use devm_platform_ioremap_resource
>   dmaengine: tegra-apb: Use devm_request_irq
>   dmaengine: tegra-apb: Fix coding style problems
>   dmaengine: tegra-apb: Remove runtime PM usage
>   dmaengine: tegra-apb: Clean up suspend-resume
>   dmaengine: tegra-apb: Add missing of_dma_controller_free
>   dmaengine: tegra-apb: Allow to compile as a loadable kernel module
>   dmaengine: tegra-apb: Remove MODULE_ALIAS
>=20
>  drivers/dma/Kconfig           |   2 +-
>  drivers/dma/tegra20-apb-dma.c | 481 ++++++++++++++++------------------
>  2 files changed, 220 insertions(+), 263 deletions(-)

Test results:
  13 builds: 13 pass, 0 fail
  12 boots:  11 pass, 1 fail
  38 tests:  38 pass, 0 fail

Linux version: 5.5.0-rc5-gf9d40c056c0f
Boards tested: tegra20-ventana, tegra30-cardhu-a04, tegra124-jetson-tk1,
               tegra186-p2771-0000, tegra194-p2972-0000,
               tegra210-p2371-2180
