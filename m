Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B65EEE1C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiI2Gyb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiI2Gya (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 02:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10112F761;
        Wed, 28 Sep 2022 23:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 748BE62034;
        Thu, 29 Sep 2022 06:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51216C433C1;
        Thu, 29 Sep 2022 06:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664434468;
        bh=YcLlOQxpSiDySo3EUZFNRgxanjy0X9OiJc+1dqkbPdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFNlSUVEdbNJpW4lAo6ef4ldR0uxOtgLKfNodzTlA44rTNlpUthtT4XfjvcdUguIq
         n1VAntq0agqXf8OQSenoiqeYnubg5mozAF429rLJFi3F4n+MvBsrf449E61PBgCgYl
         NKfCP670p2SPwvZOZycQcw8Cp/kwezOvslwXPVYPb2TCbHZ6m05PXGgpVIOpykS9Ak
         u9i3WLK+r0YH9qcK0mmPFyaR4ouPS+m0U11CFYzgmhxmFgVyXWom9IErTNywpEDUQr
         43LeEXl1602axQ8cxBxRB6mr89LDYRLo/F3VZCi99AM/NBPuV/u6AzP3o1ppE5k9qx
         IGQOTxkCAMcuQ==
Date:   Thu, 29 Sep 2022 12:24:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl08x: Fix double word
Message-ID: <YzVBIY0C7L8o739j@matsya>
References: <20220830150708.24507-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830150708.24507-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-08-22, 11:07, Shaomin Deng wrote:
> Fix the double word "many" in comments.

Applied, thanks

-- 
~Vinod
