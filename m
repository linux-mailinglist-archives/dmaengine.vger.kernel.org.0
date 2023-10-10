Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32F37C0323
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjJJSBU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJJSBU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 14:01:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42294
        for <dmaengine@vger.kernel.org>; Tue, 10 Oct 2023 11:01:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DFFC433C8;
        Tue, 10 Oct 2023 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696960878;
        bh=1VZlB+9ARQ/RUTUA/rHXorjZE1GKKlOGL/rlwGR82FQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tsfa3h8FGdqe57cXLDdnQu9gdBAEnW19uWPdqnGA2UBiFduRqmv9taW2d1bYOr6R5
         J2XMTdAXEfX0V21NO26qW+BRcQK7PGUce5g3QoVGOvRRAp/c2nH4oIOIFKdaDLK4Th
         0oRSQgSrMq6g5JUvUKgrIOuv2+ml3FmeoOaeT8kKNEEAg3luYecr7uda7pAX6dVbdW
         j4qFcsX6q7jciC+zyFlo9f8nA39uiGfyt1kSzUjEUDpVWpq8lGMkdk1gqT7gYg/6GW
         4GL2tpPuk3YRtQrbVfDxaxFUaYdgMv7IaDzHMD/u5FO41Qc4Ry44vHT0liEtEN65oR
         3e0+yO5msTW/Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20231010065729.29385-1-vkoul@kernel.org>
References: <20231010065729.29385-1-vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: mmp_tdma: drop unused variable 'of_id'
Message-Id: <169696087711.52248.11371516127952846322.b4-ty@kernel.org>
Date:   Tue, 10 Oct 2023 23:31:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 10 Oct 2023 12:27:29 +0530, Vinod Koul wrote:
> Recent change a67ba97dfb30 ("dmaengine: Use device_get_match_data()")
> cleaned up device tree data calls but left an unused variable, so drop
> that
> 
> 

Applied, thanks!

[1/1] dmaengine: mmp_tdma: drop unused variable 'of_id'
      commit: 8bf914570650ec5858e18554d70d2838cef01de1

Best regards,
-- 
~Vinod


