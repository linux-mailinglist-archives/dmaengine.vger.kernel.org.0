Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6270557F
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEPR4H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjEPR4G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BA19A4;
        Tue, 16 May 2023 10:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DD8C635BD;
        Tue, 16 May 2023 17:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FACFC433EF;
        Tue, 16 May 2023 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259765;
        bh=dMvJNmxm7ShEtGYKXRKqv+Z2pTlnKWUJlghMF8tsiZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPU3py4Y4k2P4WqWE0RXt+YPzvIulH51/ROKKBq/cGxHRU7nhFcyktaLgNROwSFan
         P/WMAHZGEKbfrTyVvrKD7VSfR1U+zxCjXU/Xlnvj4D5MCIYR3Oxa5ylypVNI9VagUR
         7kBLVcEBNzxuO2e/W/+J8U0C6fO9elpSGqEjjLsal28ESSdtAI/8FKApEEcC8U8DBC
         9InnXGJVnSoBeQ/Y1wK+TemfdVyz1OSX5+Kqo6aP46g+v1v62ByhY3URXaYbQPM56v
         R95jvEZaDR8YalZADzykYtHbY3CNaJhRA6MtV2f3jcZ+qyzWzqKOwZ+uig4cgNatyc
         tr//AcYzFOITg==
Date:   Tue, 16 May 2023 23:26:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     peter.ujfalusi@gmail.com, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        u-kumar1@ti.com, j-choudhary@ti.com
Subject: Re: [PATCH v3 0/2] Add support for J721S2 CSI BCDMA
Message-ID: <ZGPDsGGLzkf/PZXg@matsya>
References: <20230505143929.28131-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505143929.28131-1-vaishnav.a@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-05-23, 20:09, Vaishnav Achath wrote:
> This series adds support for J721S2 BCDMA instance for Camera Serial
> Interface (CSI). 

Applied, thanks

-- 
~Vinod
