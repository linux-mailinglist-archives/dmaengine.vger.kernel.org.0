Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAC3957EC
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEaJSc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 05:18:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58134 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEaJSc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 May 2021 05:18:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14V9GglZ070674;
        Mon, 31 May 2021 04:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622452602;
        bh=Its6+pOD1tBTaXUgRpY3KMtTS3wCWqo3YueW1RmMxa4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bhyHSF86k7TkEqFAYrfbkzaEnncWTx402W1pNM9x25C2B1kNpEgNcgH4kGbvr/E/v
         mkTSAKmvn2Azip1C/SjOXBGxfZyyDEqj3m6J64QRdoUp/jX6wFsMnuXj0ATGFU9RYB
         t/TCtI9r09p9pjLXGiqOM4a5o6WIWnMcSKA4ahyA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14V9GgR2072205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 04:16:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 04:16:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 04:16:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14V9GfmG035500;
        Mon, 31 May 2021 04:16:42 -0500
Date:   Mon, 31 May 2021 14:46:40 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
CC:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 11/18] dmaengine: ti: k3-psil-j721e: Add entry for
 CSI2RX
Message-ID: <20210531091638.6mynfeusuzlgegdr@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-12-p.yadav@ti.com>
 <916ef8c9-e444-afa4-d544-8fa672690fdb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <916ef8c9-e444-afa4-d544-8fa672690fdb@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/05/21 09:51AM, Péter Ujfalusi wrote:
> 
> 
> On 26/05/2021 18:23, Pratyush Yadav wrote:
> > The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
> > have up to 32 threads but the current driver only supports using one. So
> > add an entry for that one thread.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Add all 64 threads, instead of having only the one thread being
> >   currently used by the driver.
> 
> How many threads CSI2RX have? 32 (as per commit message) or 64? If I
> recall right, it is 32.

Ah, sorry I forgot to update the commit message. Each instance of CSI2RX 
has 32 threads, and J721E has 2 instances. So 64 threads total.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
