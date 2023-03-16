Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43F6BD6AD
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 18:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCPREO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCPRD7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 13:03:59 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDA20E7EE0
        for <dmaengine@vger.kernel.org>; Thu, 16 Mar 2023 10:03:24 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 23C3D27583;
        Thu, 16 Mar 2023 18:03:16 +0100 (CET)
Message-ID: <529849b0-2ba9-85bf-c57f-0abe93cfdc42@gpxsee.org>
Date:   Thu, 16 Mar 2023 18:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, dmaengine@vger.kernel.org
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
Subject: XDMA crashes on zero-length sg entries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,
The Xilinx XDMA driver crashes when the scatterlist provided to
xdma_prep_device_sg() contains an empty entry, i.e. sg_dma_len()
returns zero. As I do get such sgl from v4l2 I suppose that this
is a valid scenario and not a bug in our parent mgb4 driver. Also
the documentation for sg_dma_len() suggests that there may be
zero-length entries.

The following trivial patch fixes the crash:

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 462109c61653..cd5fcd911c50 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -487,6 +487,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct 
scatterlist *sgl,
         for_each_sg(sgl, sg, sg_len, i) {
                 addr = sg_dma_address(sg);
                 rest = sg_dma_len(sg);
+               if (!rest)
+                       break;

                 do {
                         len = min_t(u32, rest, XDMA_DESC_BLEN_MAX);

M.
