Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9839A151
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFCMpl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 08:45:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49810 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFCMpl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 08:45:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153ChlMY102052;
        Thu, 3 Jun 2021 07:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622724227;
        bh=1g7f2iazNLoRP6uhUTcbq8C+Xj9mTn/TWmB4q7LOYQA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uMW89sKGfRqX3wUKfNHVidskiY08d3MivnaPcdrQIkdYeLOD5E+5cf92U2V0aM5Km
         fdVDBpcVRy9V/1bPTbNPbHnRESMIwahVsYXZMMIYZaTYQFGNvdLJQlLUmB64iWkTrw
         aZOyHrIa05mYWiTZNHXSLUjzJcjQkC8ne4oOVVfY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153ChlEi043928
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 07:43:47 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 07:43:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 07:43:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153ChkqU119106;
        Thu, 3 Jun 2021 07:43:46 -0500
Date:   Thu, 3 Jun 2021 18:13:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Maxime Ripard <mripard@kernel.org>, <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <devicetree@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>,
        <dmaengine@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-phy@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 14/18] media: dt-bindings: Add DT bindings for TI
 J721E CSI2RX driver
Message-ID: <20210603124343.mpyjdc7yxcnajkc3@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-15-p.yadav@ti.com>
 <1622125407.764961.731785.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1622125407.764961.731785.nullmailer@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/05/21 09:23AM, Rob Herring wrote:
> On Wed, 26 May 2021 20:53:04 +0530, Pratyush Yadav wrote:
> > TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> > capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> > parts together.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Rename to ti,j721e-csi2rx.yaml
> > - Add an entry in MAINTAINERS.
> > - Add a description for the binding.
> > - Change compatible to ti,j721e-csi2rx to make it SoC specific.
> > - Remove description from dmas, reg, power-domains.
> > - Remove a limit of 2 from #address-cells and #size-cells.
> > - Fix add ^ to csi-bridge subnode regex.
> > - Make ranges mandatory.
> > - Add unit address in example.
> > - Add a reference to cdns,csi2rx in csi-bridge subnode.
> > - Expand the example to include the csi-bridge subnode as well.
> > - Re-order subject prefixes.
> > 
> >  .../bindings/media/ti,j721e-csi2rx.yaml       | 101 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/media/cdns,csi2rx.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/media/ti,j721e-csi2rx.example.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/media/cdns,csi2rx.yaml'
> make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/media/ti,j721e-csi2rx.example.dt.yaml] Error 255
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1416: dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1484096
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.

I think this is the case here since it can't find the 
ti,j721e-csi2rx.yaml file.

> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
