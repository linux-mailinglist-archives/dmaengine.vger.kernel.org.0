Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47418567DA4
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiGFFSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGFFSd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:18:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C659816598;
        Tue,  5 Jul 2022 22:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7255DB818BD;
        Wed,  6 Jul 2022 05:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B92FC3411C;
        Wed,  6 Jul 2022 05:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657084710;
        bh=rFooaBo/J4NloHCfi9QoTaDky27Ong0+JFePdMMXiwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkXLWM4eMZZBrjLC25MdwnauecKYx2drzXc0HDus8nCwMOPFf1qlVX+xP9GCH8EUq
         AOdiOvCknIeTj6kzsbghbDzXulPDkscBMQYtBE3YwMcIcU/02+GFCZViOdsmcsu/Ul
         0ZRL64iTT4LpcoLiBxlBAkJisoh8eX8w+CBL4vE5qGwmSSlZgBBDdCPl6eQG+O3ddU
         mzgl3AQJVGI65YeKuHu+Huh5WqVmJkBOrxRYSwtsSqsvYYI2Qf5RQ58Zy36A6EPEAv
         mLEKX4Ml84Q7vdI+lEVp1imjrq5ElzdIZet6ABBFVrJYmltZOTK639huyDM97qYS5S
         DH6oYjo892dMA==
Date:   Wed, 6 Jul 2022 10:48:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx_dpdma: Omit superfluous error message
 in xilinx_dpdma_probe()
Message-ID: <YsUbIVvzQ4Evvc9L@matsya>
References: <20220519130855.7664-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519130855.7664-1-tangbin@cmss.chinamobile.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-05-22, 21:08, Tang Bin wrote:
> In the function xilinx_dpdma_probe(), when get irq failed,
> the function platform_get_irq() logs an error message,
> so remove redundant message here.

Applied, thanks

-- 
~Vinod
