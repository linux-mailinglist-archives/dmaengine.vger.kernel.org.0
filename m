Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A396CA864
	for <lists+dmaengine@lfdr.de>; Mon, 27 Mar 2023 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjC0PBk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjC0PBi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 11:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E84D4483;
        Mon, 27 Mar 2023 08:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE6061303;
        Mon, 27 Mar 2023 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FC4C4339E;
        Mon, 27 Mar 2023 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929296;
        bh=dsoVd3bOkZ1/OXyt+ZP8t5ze5tdgtMoUGRvUuV6EukM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHPAMbr7ynIEkq5oNWhug9hIbn4LJ0wlRJ6JgemhXBguNbBUPRRDeUdVcqazMWkWC
         dk9d8QHtU103JjtWCjNwzZLwSakTbYVoyyZMPznbW2kNkDFCK+lV/7pj97e//rbFdB
         KAcjBslm3nZ5BD8UOtzQgE313X4qN68GC8CjlYGQyBtCbPdHgVt918IpKotLwM74ca
         Zn52WHW55dJ8f6+KX/RVedxJw0EkqlPTOL1x9rcwK7iDgIZU3Ce79U8tYgcWxannLX
         MEStSzPPRTj0snsGEx0UFdc0kYSX/e0hXkgCvgkTLp0pcdTYZYHGlYYERA/m/ZwxGN
         9en6lprtJ6hkQ==
From:   Will Deacon <will@kernel.org>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-gpio@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-modules@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, asahi@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/24] MODULE_LICENSE removals, second tranche
Date:   Mon, 27 Mar 2023 16:01:15 +0100
Message-Id: <167992609868.3834946.4831319626649638477.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 17 Feb 2023 14:10:35 +0000, Nick Alcock wrote:
> This series, based on current modules-next, is part of a treewide cleanup
> suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
> files/objects that are not tristate.  Due to recent changes to kbuild, these
> uses are now problematic.  See the commit logs for more details.
> 
> (The commit log prefixes and Cc lists are automatically determined using
> the script mentioned below.  I've eyeballed them, and they seem reasonable:
> my apologies if they are not.)
> 
> [...]

Applied drivers/perf patch to will (for-next/perf), thanks!

[08/24] kbuild, drivers/perf: remove MODULE_LICENSE in non-modules
        https://git.kernel.org/will/c/a64021d3726a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
