Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA3B12AD50
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2019 16:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLZPtI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 26 Dec 2019 10:49:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:36804 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfLZPtI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Dec 2019 10:49:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2019 07:49:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,359,1571727600"; 
   d="scan'208";a="243003872"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga004.fm.intel.com with ESMTP; 26 Dec 2019 07:49:07 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Dec 2019 07:49:07 -0800
Received: from fmsmsx118.amr.corp.intel.com ([169.254.1.58]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.125]) with mapi id 14.03.0439.000;
 Thu, 26 Dec 2019 07:49:00 -0800
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "alexander.barabash@gmail.com" <alexander.barabash@gmail.com>
Subject: RE: [PATCH v2] ioat: ioat_alloc_ring() failure handling.
Thread-Topic: [PATCH v2] ioat: ioat_alloc_ring() failure handling.
Thread-Index: AdW7TGc/gGAW5DKzQbaZyKysabWdZgAt4XFw
Date:   Thu, 26 Dec 2019 15:48:59 +0000
Message-ID: <112A412BB11A1242B37129D931BCE534A40B8CC2@fmsmsx118.amr.corp.intel.com>
References: <75e9c0e84c3345d693c606c64f8b9ab5@x13pwhopdag1307.AMER.DELL.COM>
In-Reply-To: <75e9c0e84c3345d693c606c64f8b9ab5@x13pwhopdag1307.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: dmaengine-owner@vger.kernel.org <dmaengine-
> owner@vger.kernel.org> On Behalf Of Alexander.Barabash@dell.com
> Sent: Wednesday, December 25, 2019 10:56 AM
> To: dmaengine@vger.kernel.org
> Cc: alexander.barabash@gmail.com
> Subject: [PATCH v2] ioat: ioat_alloc_ring() failure handling.
> 
> If dma_alloc_coherent() returns NULL in ioat_alloc_ring(), ring allocation
> must not proceed.
> 
> Until now, if the first call to dma_alloc_coherent() in
> ioat_alloc_ring() returned NULL, the processing could proceed, failing with
> NULL-pointer dereferencing further down the line.
> 
> Signed-off-by: Alexander Barabash <alexander.barabash@dell.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/ioat/dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c index
> 1a422a8..18c011e 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -377,10 +377,11 @@ struct ioat_ring_ent **
> 
>  		descs->virt = dma_alloc_coherent(to_dev(ioat_chan),
>  						 SZ_2M, &descs->hw, flags);
> -		if (!descs->virt && (i > 0)) {
> +		if (!descs->virt) {
>  			int idx;
> 
>  			for (idx = 0; idx < i; idx++) {
> +				descs = &ioat_chan->descs[idx];
>  				dma_free_coherent(to_dev(ioat_chan),
> SZ_2M,
>  						  descs->virt, descs->hw);
>  				descs->virt = NULL;
> --
> 1.8.3.1

