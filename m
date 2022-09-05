Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80A5ACA78
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiIEGVi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiIEGVh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A582B261;
        Sun,  4 Sep 2022 23:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6DC61117;
        Mon,  5 Sep 2022 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DEDC433C1;
        Mon,  5 Sep 2022 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662358896;
        bh=TNEBXej6R4HHqPME+PDj0XbbBvp7eLyz70MrlYZp+3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BR8qdVIR528CcfShi4QQ+GyEKrWei5bNy6DNa3TG2xaTpFUdzfbyadPKEYFMHuRY/
         FflO2Mh9+sTVFWgiF6J75U7GidHvnvhH0AThdq+bJNmnTQLJebWdgvG9+xTIskY9iD
         dsP6YhhIdHQoCrjHiMQ1ldSUNWyXSUBf6PlvQmoyUIUeTiPXgOpYZjFjO+yv3sqeH5
         W7Nd9m3KOTapAQyXcglLTHJaJF1EqIXLghVIkDviGWBPQ2pCHQhLr2y889GKIWFU7v
         rn17LNN5Qfue+/in2U77zdKjd7zTM3nWUJumYomc7v82jHJARUX6t7wSrh6YpoAO7n
         ANJ5D17LHUYBQ==
Date:   Mon, 5 Sep 2022 11:51:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dmamux: Fix comment typo
Message-ID: <YxWVbHlow2zOCe4r@matsya>
References: <20220811120959.18752-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811120959.18752-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-08-22, 20:09, Jason Wang wrote:
> The double `end' is duplicated in the comment, remove one.

Applied, thanks

-- 
~Vinod
