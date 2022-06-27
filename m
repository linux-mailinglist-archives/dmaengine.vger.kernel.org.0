Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D155CB1D
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiF0G3r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 02:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiF0G3r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 02:29:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED8CD1;
        Sun, 26 Jun 2022 23:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B275B80D4C;
        Mon, 27 Jun 2022 06:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FF9C341C8;
        Mon, 27 Jun 2022 06:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656311384;
        bh=R7zUKJvjac3+R93qtYp1Kjlt5PZnytu65Y8KFJCsinE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pg3tAyQ5msUDwgFbAfN4mPh7VhoQnPIOHklY12C/+Cr/A/HLzOfTMQ3Q5NXtZe716
         SvEaukyYSJeDukdzjqImF6VPneKLNpulu1Q4/pd2JbLfpIp09GhK0fMPWKJpso+rh4
         Vk/0tU9TemRMbmcnUfGEwzloAQDqf1mAvfv1qzJ8Yp98FSvhOArm4CDp+HthkUYPWu
         3KR74vOBWytx5dAt9snkghK4Aent6n3b6jrUlWZmhlzHW+KuE0B1ZcDjKnOkFhl2+Q
         SyOAWfxFkJaDY2K8QUdLGSSVz2DzYzdNXNvbCLCfoWdM0p92SsgKAVzsbIruchj0ru
         1VYtY534l+/yQ==
Date:   Mon, 27 Jun 2022 11:59:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] dmaengine: Support polling for out of order
 completions
Message-ID: <YrlOU4uQpgsjkBcZ@matsya>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
 <20220622193753.3044206-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622193753.3044206-1-benjamin.walker@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Ben,


On 22-06-22, 12:37, Ben Walker wrote:
> This series adds support for polling async transactions for completion
> even if interrupts are disabled and transactions can complete out of
> order.

Pls cc relevant mainatiners and list on cover as well please so that
they get the context of this work. Also, I notice some patches are cced
to lists but no maintainers, that needs to be updated... People may not
look, you need to make it easy for them...

-- 
~Vinod
