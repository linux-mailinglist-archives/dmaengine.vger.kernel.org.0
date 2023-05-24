Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167F570EEAC
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 08:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbjEXG4K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjEXGzg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 02:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47B10CA;
        Tue, 23 May 2023 23:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1432763990;
        Wed, 24 May 2023 06:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9834BC433EF;
        Wed, 24 May 2023 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684911286;
        bh=2dufkZRvuZe+LYKDbga1c2RGS/mrd5DzOCcRv+UfAZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5W3BRyUUcjHqDJ2pWtHUpTRbue3c+xu8cwyUPXsOUbFWSmlIaPLNNQ/qBXNpyPQH
         ZX2MSBr8yFWSkKYc2oTqfQ28zowfGaGfX6UFmAzRQHoeS63/VkhC5LHREkg6pV2w36
         NWbg+t23nS2nYAzvKNBIUT5ItHdaNIZ9jMaHLABAkJuUGJdwlDywVgbdJNFKBm3ON2
         PiuU5aJ8c0+IYljffJcNneSBYzXMu9lXOXsk2Kl64sTBomtlHjWRVokcrH55JYm6qU
         FToMckoaJCqZ8gK5RjqLko0DbM7DuDqVLEtoM0LblOROl/FM/TTg4ATZXHPDUkSMTk
         djKKF1NfRhNFw==
Date:   Wed, 24 May 2023 12:24:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/5] dma: don't set chancnt
Message-ID: <ZG20snavUcrYpTIZ@matsya>
References: <20230521100252.3197-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521100252.3197-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-23, 18:02, Jisheng Zhang wrote:
> I'm patching dw-axi-dmac to add more features, but I found a small
> clean up point and some drivers in drivers/dma/ have the same issue,
> so this series comes.
> 
> The dma framework will calculate the dma channels chancnt, setting it
> is wrong.

Applied, thanks

-- 
~Vinod
