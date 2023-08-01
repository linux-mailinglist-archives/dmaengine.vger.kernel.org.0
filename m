Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D308F76BCD7
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjHASpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjHASpn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACF2D65;
        Tue,  1 Aug 2023 11:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08C9F61693;
        Tue,  1 Aug 2023 18:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE5C433C8;
        Tue,  1 Aug 2023 18:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915530;
        bh=Nhz5Wii0uGhKg7orUacxhEHYXiOEvQZsqyKjQ5bqZ+8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=XJBHPBnIFyluzxfIBYOs/kaWKNTJTo/gG1PT8AXIezN97zH5dqDWvtc/EHXgxsfPr
         ZS8Ly1OQOpn47gSLVxH16MS3hR0t1BoPK1ZwXKIanicsdGawbEaTorIgHwpSbbaIzR
         gFYFW1RRoY1qVTt8l05SwWcOP9uSH58gB3Vn3odtvdXPkJ06KVq6zRz+aNJK3Vjq/h
         tRZbHRgmQVuvAi4WgAKDv6hEWt+Koev7uiRL2uBe1HsM0Vf6XKORFKi/MlaP6h7wdx
         n1NR93yUmsNgjs1plpwfrp6sG5BI7bCp19H+0i7K+//86hUDAYUC8sCKlL5VHLbSWY
         EqG63Fn5BmebQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20230728102451.265869-1-varshini.rajendran@microchip.com>
References: <20230728102451.265869-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v3 12/50] dt-bindings: dmaengine: at_xdmac:
 add compatible with microchip,sam9x7
Message-Id: <169091552668.69468.5352269983442085159.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:15:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 28 Jul 2023 15:54:51 +0530, Varshini Rajendran wrote:
> Add compatible for sam9x7.
> 
> 

Applied, thanks!

[12/50] dt-bindings: dmaengine: at_xdmac: add compatible with microchip,sam9x7
        commit: 0f264ab788ed9a39aabb36c0b35e5821b94bcdc8

Best regards,
-- 
~Vinod


