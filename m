Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042BA7680DF
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jul 2023 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjG2SB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jul 2023 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2SB4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Jul 2023 14:01:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC955FF;
        Sat, 29 Jul 2023 11:01:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso30760315e9.1;
        Sat, 29 Jul 2023 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690653710; x=1691258510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/D7UZ40/zf+BKHR7Fn0OH/OzzIWuG5A8dT87agr1pY=;
        b=MxpgEadQIA0f/tBYTFLSTBX5dyAfBleoJzitmLXO+UK3Fve4oD6NLsxfecgA2+7Qhb
         jbnVW07sUAibn6J4ZItdpt3p9qgPnydXwnJLRwO9Of9PNpwK49BD+R4hjmhuUggcpU9H
         Nqgquoyb9cKos8RkqpD6WTpZ4jbeB5ZN5rmxc4zcUKYdEQRmEFcBQO8L2StoFphpKRPO
         DiXX2hYdXciKP1n6UuNFti6jNk+M5aUHLW/1pz56WMvwJYsjFUW9rMKVMfOV88TB9yf2
         u4JDjyJAzsRX6k3K4cUWi4dd1PqT78AuZU6lWMlNldaq3dCwbpzW9uvreIikRyID5e4H
         4TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690653710; x=1691258510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/D7UZ40/zf+BKHR7Fn0OH/OzzIWuG5A8dT87agr1pY=;
        b=HL3Aj0IvH6MelNUpuQmRCpu0EcJEaNhnxpqYxhCXhQ1pFMFALHbzb/7KCiK7NMIZ89
         z12NdfZ9C64CIXZUff/n5UB8vSQZS3jelik//8anZLpxzGE9ag+NDcuk/SSJhMmVWTTU
         2UgkZmd9rv9IsQVxX3xzc+10BASHtQozt2iu98FZXsDDv4vWunACfa41qLBGe8HcHxul
         IDTMPZOvrs51oqiY1MD3GH6zUltj+ObKydPhk8TYq6WZxEMay3SVDuwAuuOPrAP7Re4Z
         MeXnw7Y1vlPoz6bNl4j2+IYGVBo6BbnnYltXfGz09sHNU1uG62un4dJsHlE0fsF5p60b
         R9JQ==
X-Gm-Message-State: ABy/qLapLo1Y02n0AlasWvjf/hW6MkemwCYnBr3g9CwHfI/z5ScQWkGQ
        4/QiClgEwtrKvr1E5vHp+5Hmx0zuJkSvTHKJrArr3IMmsEqCRF8m
X-Google-Smtp-Source: APBJJlEbCfbG4CGKMzNSjeLo8Ymwix5ZCWhDMZkMRYFYD2advMJFU4OFySYBG6VmwYMRz5quKNjJQHHCLSd12O74I+c=
X-Received: by 2002:a05:600c:2194:b0:3fd:d763:4499 with SMTP id
 e20-20020a05600c219400b003fdd7634499mr3883452wme.36.1690653710109; Sat, 29
 Jul 2023 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230726104827.60382-1-dg573847474@gmail.com> <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
 <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr> <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
 <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com> <bc09cdb8-f349-0eae-8624-457d85d768d4@deltatee.com>
In-Reply-To: <bc09cdb8-f349-0eae-8624-457d85d768d4@deltatee.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Sun, 30 Jul 2023 02:01:39 +0800
Message-ID: <CAAo+4rVKUDZiN9sDTj6MszUE7=wMjj5LDqOocUQSq_c8r+4EpQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on &plxdev->ring_lock
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, Yunbo Yu <yuyunbo519@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Yes, I think you can just send a revert patch explaining the reasoning
> further in a commit message.

v2 patch is just sent to address the problem.

Best Regards,
Chengfeng
