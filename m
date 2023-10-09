Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1D7BD316
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjJIGMW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbjJIGMU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A2BA4;
        Sun,  8 Oct 2023 23:12:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0755C433C7;
        Mon,  9 Oct 2023 06:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831939;
        bh=ie4AUCy8wukqhGEqThy7NvmjKahytl7YPvKyPQ1aAxo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UsHCsaCtRLhbe7N4/cmjQ/VxDb+xUj/cisKv+oggDN3bh61EddpkiUnV9aEuHmny2
         hIPaicQk1Fwi2z31CNYe+JMKF9gVm2plNmOR7rf1ofYsX6yL9TO7egkjjX2F9sT+tL
         k1wHQP3t3pc/7ZNL2BQHFu0rxqzrSLG2WKAw4vf9Rqi6jQBDWAKbV472P5OmzIjUNW
         X1pq6x+YBn1SNPPn74AX1hlK+INP75H21yC+wkTcScSZl7couCyKuRfVLTx40I2gfv
         mSC/tD0Fj1A+e+YlrbwY8k0OklsG0Op7iLifM3KCvafPscmjRQYmfw+VZy+2u30Nj/
         tfeD/BC+s5SxA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231006213844.333027-1-robh@kernel.org>
References: <20231006213844.333027-1-robh@kernel.org>
Subject: Re: [PATCH] dmaengine: Use device_get_match_data()
Message-Id: <169683193754.43997.16774185911691543891.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:17 +0530
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


On Fri, 06 Oct 2023 16:38:43 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] dmaengine: Use device_get_match_data()
      commit: a67ba97dfb30486deb4661f770b954387acc898d

Best regards,
-- 
~Vinod


