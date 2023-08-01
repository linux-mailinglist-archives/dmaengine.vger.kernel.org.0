Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56DC76BCC8
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjHASpV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjHASpU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78C2701
        for <dmaengine@vger.kernel.org>; Tue,  1 Aug 2023 11:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A776B6166E
        for <dmaengine@vger.kernel.org>; Tue,  1 Aug 2023 18:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F0C433C7;
        Tue,  1 Aug 2023 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915504;
        bh=68wUTC0o5mabLVsfaMiNDMxzfpBk3AoVlcz7Jd7EOPM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PSRTQ1xTz9Cb8QyXb8K1vwdnysTAWfTHKxz/KQrKyNytybGc3fC8kTN0uwjskzaX+
         /qDhyYEdLa2+nd6uYpyY5sqhdQuIR5l1TVUWop4I2uKOhhWQ/p2FbgEIqQj8momexz
         QaNrrO/UzXd0NzFaxkmWZGvuBv7hiz6cx5E2WBk+X4Y6XU9EriTXnLiGLz85xeKElG
         gugnE9LRTTjxSdTX4NyynXfZd7evco+Awt8BAPKsbOIlUL7uttVQZrnND0B/6LicLY
         wada2iD7aiCaCGUivMjHBai7UEQQBHK1I1l6lVtGVyASLakDiG/jJksVjQsepmBN5H
         4weObSH4Da3LA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dmaengine@vger.kernel.org, arnd@arndb.de,
        Fabio Estevam <festevam@denx.de>
In-Reply-To: <20230729192945.1217206-1-festevam@gmail.com>
References: <20230729192945.1217206-1-festevam@gmail.com>
Subject: Re: [PATCH] dmaengine: ipu: Remove the driver
Message-Id: <169091550232.69468.4348142509737112075.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:15:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 29 Jul 2023 16:29:45 -0300, Fabio Estevam wrote:
> The i.MX3 IPU driver does not support devicetree and i.MX has been converted
> to a DT-only platform since kernel 5.10.
> 
> As there is no user for this driver anymore, just remove it.
> 
> 

Applied, thanks!

[1/1] dmaengine: ipu: Remove the driver
      commit: f1de55ff7c704b48389987f6c71ca31dc8cffe8d

Best regards,
-- 
~Vinod


