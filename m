Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94406BEFA6
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCQR1y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQR1x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ABA4A1E5;
        Fri, 17 Mar 2023 10:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E8D60C4F;
        Fri, 17 Mar 2023 17:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2D8C433D2;
        Fri, 17 Mar 2023 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074071;
        bh=jndQHit195KBvWMhsOIddHvsMuXgMNp6uR4mGTssJYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yod0pdgrjwBZJ+7mTHH/uqT6k43wa8oRcBlKXk4Cf9VFblf+wtytqZJ3NY1i/S6ZS
         6vz9VVxgf6lExT8T/M8wSMNQi/oYo5SSaBd64O6KoKYurwQYmRg71xXYR8hryoqYJi
         ivUnNBhvY79bGM3aXdB9GEwLxVbLWbw47qvzjDVmTLYu4NxHItFYq7C5nhtbtJzeIt
         wtMyY6h/6Zxx5ZBsW5r/7/loP5IMnakG9FERCkw4hmcI1C8T8x5Yh0qEKDsXiCX1VU
         pjJwQXqCkA5BzvQYPGgAtScVE18eQ/eARWdN646aTf/xnU/htWaxjKIJUJDvba7sFz
         fb8vuAPESFy6A==
Date:   Fri, 17 Mar 2023 22:57:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: rz-dmac: Document clock-names and
 reset-names
Message-ID: <ZBSjE8cQnspW4VSC@matsya>
References: <20230315064726.22739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315064726.22739-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-03-23, 06:47, Biju Das wrote:
> Document clock-names and reset-names properties as we have multiple
> clocks and resets.

Applied, thanks

-- 
~Vinod
