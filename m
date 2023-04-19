Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA86E7501
	for <lists+dmaengine@lfdr.de>; Wed, 19 Apr 2023 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjDSI1N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Apr 2023 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjDSI1M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Apr 2023 04:27:12 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F30E51;
        Wed, 19 Apr 2023 01:27:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J8R6Ej028178;
        Wed, 19 Apr 2023 03:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681892826;
        bh=fpxwJ4UuCMRbCcS/k/rtxuIckU067HMuYB3fKrjP3yc=;
        h=Date:To:CC:From:Subject;
        b=mL8Dy4ulpeN+pLr9vNqZNsgRC0yE11hf8R1fsONMiUgciDhgrA6l2Au4LrO02Pc/M
         MlphJdC7ERymUWdRboD79MyEymnXyCuhN5xBMv4QcV9BWg/0gw/r0N3G7VQrOFwYZU
         hpO9PK4CEHLle9XyBXxgS71pIeFwkxUQr0ivALTc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J8R6dw104653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 03:27:06 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 03:27:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 03:27:05 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J8R2Sp017432;
        Wed, 19 Apr 2023 03:27:03 -0500
Message-ID: <291807c9-8d1c-56f0-ee39-4d221e18bd1a@ti.com>
Date:   Wed, 19 Apr 2023 13:57:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vkoul@kernel.org>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        "J, KEERTHY" <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        "Menon, Nishanth" <nm@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
Subject: Question: dmaengine: dma_request_chan_by_mask() and DMA controller
 probe order
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

In dma_request_chan_by_mask() , the probe defer logic returns -EPROBE_DEFER if
there are no DMA devices registered yet. But in case of multiple DMA controllers
in an SoC and when only one(or a subset) of the controllers have finished probe
dma_request_chan_by_mask() can return -ENODEV incorrectly since the first DMA
device probed might not support the particular mask requested.

What is the recommended solution to avoid situation like these?

Consider the following scenario for example:

SoC has two DMA controllers, one instance of system DMA, one dedicated for
Camera subsytem which does not support DMA_MEMCPY and has lesser number of channels.

* Camera subsystem DMA is probed first.
* Another peripheral requests dma_request_chan_by_mask(DMA_MEMCPY)
* dmaengine returns -ENODEV for above as the controller with DMA_MEMCPY support
is not ready yet.
* System DMA is probed later but peripheral driver failed to start with DMA.

-- 
Thanks and Regards,
Vaishnav
