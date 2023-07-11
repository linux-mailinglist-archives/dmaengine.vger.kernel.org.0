Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F174F5D6
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjGKQoW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjGKQoD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915071BCB;
        Tue, 11 Jul 2023 09:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D798C6157A;
        Tue, 11 Jul 2023 16:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34699C433C7;
        Tue, 11 Jul 2023 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093831;
        bh=DOmKeP3YX1u2v5gN3EN9k0YlWpWPqRpZhwPXxoKbZzA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=akdqRptqIKB2/c8rYMQHZ6uBe8XRBDihxJKYsgKfzkz30JYWGVoLqfVA8oOO8zoMe
         voUK63VFbmjtpLsaJsNUu7ZHyatKiVPrrYgsAHQi2RF/hoybJYNWLtN3fvwAynHY74
         +1ZrrSN9T0qwoVpWJLFU1CLvWtP9P92IOQlKgOaenLF+cIuDuO2ds9DpT3c4ophSw0
         y+4/i06J97z5KoJhLiGeNCcKn6hJMisTLyhCrYJMBV2f++xqTNlRzBxGRGfxdi/+SD
         EQCxtQHbcHLroWZOdH2unFRj73xnru6IsibuaL3D9XHpw2g1K+9DvCntlRYpVf1Pcf
         lnY9TTL+es54g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20230706112150.198941-1-biju.das.jz@bp.renesas.com>
References: <20230706112150.198941-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 0/2] RZ/G2L DMA fix/improvements
Message-Id: <168909382883.208679.2382348572508333015.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 06 Jul 2023 12:21:48 +0100, Biju Das wrote:
> This patch series aims to fix/improve RZ/DMAC driver.
> 
> The improvement patch is related to fix cleanup order in probe/remove().
> and fixes patch is related to wrong SDS/DDS settings, when we change/update
> the DMA bus width several times.
> 
> v2->v3:
>  * Added bitfield.h header file and replaced CHCFG_FILL_{SDS,DDS}
>    macros with FIELD_PREP.
>  * Updated commit header 'dma: rz-dmac'->'dmaengine: sh: rz-dmac'.
> v1->v2:
>  * Update patch header and description.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
      commit: d8fb35d80914846d25833a35acb211e59ee36046
[2/2] dmaengine: sh: rz-dmac: Fix destination and source data size setting
      commit: 48f745e247ac05dc23b0ffee189c6faba183a9d7

Best regards,
-- 
~Vinod


