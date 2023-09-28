Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21C7B1BBB
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjI1MIH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjI1MIG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 08:08:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D6121;
        Thu, 28 Sep 2023 05:08:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445D6C433C9;
        Thu, 28 Sep 2023 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902883;
        bh=lTq1dMVcm8SenHuuZd0wNqXfh3nL/EqbBBqIPVam8dY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WTAllCDmydbwqDjqOlE+YP04DsAP11/lg7bqYHgG+pqjkZLPvrAZj334yu/SIyjL9
         BJH3Y6HHOlrQ/bAWLhAPc1pBRPHzJSkVOORX6vLS75Dek+N0Rlruvf8wpHnanIkyxl
         UwekNyShwqpv0PG0ZCL2b73N4ZSXBqSVNMyN9XWVVhwfokZGSg++Fafxjr5znwNdR+
         I0ZFfwjGqHicHUUYwXNSZWGc4zwe3KTpBgLp1LyP0EKeSNv4y80MRwP8PPpqOj+OpJ
         lPdjBjt5ciSnkgqqfFVjMHSzZdx1wAOdPee8GA+xszBJycWgjR5WMAZT4Kljwum4cz
         yTdLzxvZxPwRQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com,
        m.tretter@pengutronix.de, peter@korsgaard.com,
        peter.ujfalusi@gmail.com, harini.katakam@amd.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com
In-Reply-To: <1695216326-3841352-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1695216326-3841352-1-git-send-email-radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH v2] dt-bindings: dmaengine: zynqmp_dma: add
 xlnx,bus-width required property
Message-Id: <169590287991.161554.2765505402103252498.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:37:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 20 Sep 2023 18:55:26 +0530, Radhey Shyam Pandey wrote:
> xlnx,bus-width is a required property. In yaml conversion somehow
> it got missed out. Bring it back and mention it in required list.
> Also add Harini and myself to the maintainer list.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width required property
      commit: 54a5aff6f98b69e73cba40470f103a72bd436b20

Best regards,
-- 
~Vinod


