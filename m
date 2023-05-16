Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F3705571
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjEPRvn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEPRvm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB462113;
        Tue, 16 May 2023 10:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0180163374;
        Tue, 16 May 2023 17:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D9FC433EF;
        Tue, 16 May 2023 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259500;
        bh=cHwudaIgtyc1TXIxnJt5TsmInI+WHcPDhHCqAtKxgqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lo2oI3VQi5m4vxO8oHOAUmOFtnWOIF95IaRym1Y0v1E5uJwc4DBnk3ArtK+Cc2bRl
         Lbqif+J0EdPGA5Y87Qq3+l9ySBdZ+H8KHt/0gi1QkZ052OZLq7HzeP7VI7UINVb9Ky
         LuegXJG1dmxfTFokTdWwxPl4z4FaXSb+G9i31wsYQ+Et7TDW9hk9LpJmT9+45uktGr
         D3CAzVHMQ8PVJ8uyf0YuG+iqNNLdrKbBy3yU79aQ/qf6vIWaqTSV7YPi84hy+kO1L2
         P6XDCm0QppYL1WpRllSZMFRADNmWf7D5v9Zp2oXbbWn3VAqz0ixMKFkWQx8oOznHKb
         29z4dMHbnQsBw==
Date:   Tue, 16 May 2023 23:21:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com, vigneshr@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-psil-j721s2: Add PSI-L thread map for
 main CPSW2G
Message-ID: <ZGPCqCYctEtPL62N@matsya>
References: <20230511034704.656155-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511034704.656155-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-05-23, 09:17, Siddharth Vadapalli wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Add PSI-L thread map for main CPSW2G.

Applied, thanks

-- 
~Vinod
