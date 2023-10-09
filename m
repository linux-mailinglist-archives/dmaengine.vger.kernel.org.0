Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FBB7BD328
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjJIGNE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345223AbjJIGM6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA9D47;
        Sun,  8 Oct 2023 23:12:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60681C433C9;
        Mon,  9 Oct 2023 06:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831969;
        bh=qJEBc8o2ZV06sm/dmj3FbZTvrSDw0aYx8qLgkYtyhM8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oWyg/PPfQLgsreoGrYsB8yYD4BCn+DHGyL9ftulsoNJ5xYZzrS9kncTfgUp4ur8sk
         +h56OHM285gqKhEr6TH3FVo46QLAKZGxxHWkST31AjeuRoCr/Bx4Hmv+/fFumKOSOq
         oddosbzmWDKqSYNH9JKMjPxX7t7dXKfGFlBSlp4GDJbg2GsYWUt7ZyUCJ5Wkvmz5VY
         g57aKs7IuRQJkZfSCQyTNYGUncNXB+7CbVznYq035j6B+7L5hTUDlZIkj8h/sgBvFq
         6fbWvH/jBVylJrKi64pzyhf7n8gbO6KdVyGrED9enjtLqHfmX9nv1hzfGgkSEsMTWq
         6GUIDddCtNFbQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     stable@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231004163531.2864160-1-amelie.delaunay@foss.st.com>
References: <20231004163531.2864160-1-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/3] dmaengine: stm32-mdma: abort resume if no ongoing
 transfer
Message-Id: <169683196592.44135.17868056770840545307.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:45 +0530
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


On Wed, 04 Oct 2023 18:35:28 +0200, Amelie Delaunay wrote:
> chan->desc can be null, if transfer is terminated when resume is called,
> leading to a NULL pointer when retrieving the hwdesc.
> To avoid this case, check that chan->desc is not null and channel is
> disabled (transfer previously paused or terminated).
> 
> 

Applied, thanks!

[1/3] dmaengine: stm32-mdma: abort resume if no ongoing transfer
      commit: 81337b9a72dc58a5fa0ae8a042e8cb59f9bdec4a
[2/3] dmaengine: stm32-mdma: use Link Address Register to compute residue
      commit: a4b306eb83579c07b63dc65cd5bae53b7b4019d0
[3/3] dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set
      commit: 584970421725b7805db84714b857851fdf7203a9

Best regards,
-- 
~Vinod


