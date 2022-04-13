Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D354FF6BA
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiDMM2M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiDMM2L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 08:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E35D5B3D2;
        Wed, 13 Apr 2022 05:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17426B82406;
        Wed, 13 Apr 2022 12:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23084C385A6;
        Wed, 13 Apr 2022 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649852748;
        bh=4pdtM6MKZnZCbZBKhFwlTVYlJE5fb6eW9XeeuJpkcyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6pwVrG9dVzyBf7HJZlUVLv2KT5+/IJGJ+4kX1tWVTPeRLBWZg13/6vXatDQR8kGh
         +IMmfExV2uIwWsnUXspMys6qUsjqqpPBXG+QkWPDSfl+CS1hLw/VOo9AbaAHQKSjq7
         NN16IwX8txPWcMj2liSVVPUNdeU3Sfrs1XEbl4AqrCdcYxMcTu6MOvtUqG//8RsAwm
         B393KyNNJUxx8bkVp5owo3SM58GlvJX9EWMTIHVr7Fb/1JF5tJORGV4VvBCT+kcxO1
         2O1vcn7uz6f2BTsllqCHgrjssZRoRHF8/6oLyB6O2D+H+J1OQFtGtxV1TlkDJB6rjb
         76z8D6yZWYD2A==
Date:   Wed, 13 Apr 2022 17:55:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: Add SM8350 support
Message-ID: <YlbBSDEHD4Qw+v6W@matsya>
References: <20220412212959.2385085-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412212959.2385085-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-04-22, 14:29, Bjorn Andersson wrote:
> The Qualcomm SM8350 platform does, like the SM8450, provide a set of GPI
> controllers with an ee-offset of 0x10000. Add this to the driver.

Applied, thanks

-- 
~Vinod
