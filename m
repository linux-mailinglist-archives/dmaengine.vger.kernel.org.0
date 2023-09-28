Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133197B1BB8
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 14:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjI1MIC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1MIB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 08:08:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974611F;
        Thu, 28 Sep 2023 05:08:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76180C433C8;
        Thu, 28 Sep 2023 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902879;
        bh=aagHP/tT7OX+/Nk9NY1e7msOI3MzWBd3pcmlQFBXIXM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=PNQB0J2zjPqmTiAhBoCMyuzjh2H3IsK5se2FJx8jCzFB8lV+bdsy7ULNVlKbRXL6R
         KG4l4gCoP21yAVD4QC8cr7ITEntWZjhCvmc3yop2NXifG5jiyDx2w5kkRglI8FZv3/
         BLB9tpQcf3ichOmkmHAAEqAJjXLj+JwsmlH5APtCLx9c+EJgZat4Oh0niypMV2DnfU
         8q1y2nn63VgCsxUyL1jkzV6puGC80YGwrJSCafgEVjlUsD8s8BUt5Fxfq4gaeTtc7a
         KpVx+6BWBIZSnXEp+O7YJvyb9RDzMHr5j0qeEVfmzLrm7nYnIGjvIKKDgeMTqCkKbM
         az2O+JaFtrj3g==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20230921144652.3259813-1-Frank.Li@nxp.com>
References: <20230921144652.3259813-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dmaengine: fsl-dma: fix DMA error when enabling
 sg if 'DONE' bit is set
Message-Id: <169590287811.161554.16554289447720451572.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:37:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 21 Sep 2023 10:46:52 -0400, Frank Li wrote:
> In eDMAv3, clearing 'DONE' bit (bit 30) of CHn_CSR is required when
> enabling scatter-gather (SG). eDMAv4 does not require this change.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-dma: fix DMA error when enabling sg if 'DONE' bit is set
      commit: 3c67c5236fbf7a58c1a26d57da4465ea5fb25537

Best regards,
-- 
~Vinod


