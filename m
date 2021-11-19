Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949C54569B5
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 06:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhKSFaG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 00:30:06 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36795 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231421AbhKSFaF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 00:30:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C333C3201C2F;
        Fri, 19 Nov 2021 00:27:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 Nov 2021 00:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=UymWyK7JCpRoe3xF/OIMdsGOkE
        y95ppEhh244vRZeD0=; b=PJwC7WSUd1nA4vw+VBAgf1swJKVW9oSUY21K5OmroD
        3Ycr6cGhTmCYGvNwH9YnKOtIq3H3PQWaEZLtHhtHvtc9x3h2K74eoUUqfZJJ8TAI
        1RIsHNVY1cqz/An03AtxfuUqiaWogWjUh1b2UB+b0fOUH4o4oXdx7A3ZTFVH58eY
        9d/nF//0Y92ThKFv1S60Emwzxuw5T65e2DEmE1IRJItE/PuGc06AsKfm4pP0mIkM
        SFLnZDUXSMYQK3pMhHB0ydQBS1s3eakyy8hvykHn2p+2+V4eF4cW81AV9bgTqZDD
        XlmkjJPCnQa1L8nLMqRjgfvVROa1Xz902453JKEUyw0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UymWyK7JCpRoe3xF/
        OIMdsGOkEy95ppEhh244vRZeD0=; b=jODgt3YUW5cSjzEvWeUYUcy02mqjDIRWU
        xwkiOVN4lSv3R522FIeNBkWi2KGkvwHL+R712UIY+OF1NcVqnp4CPJ7G8T3xoAt2
        0MKNwBwIf7dS8Xdz0bcO5N9hNLAzsxC5DBruwEgyJCMjKVFL2g6gcsN4vBhV5QKP
        ISDIpPGArEMQC3BeeyExu0zXzMIlJxDmm3ZPCJBqX/XENX4i2C/A+LEYAgb8QeCu
        jDHKuQNBpj1EAaDbXT4oYxwthI66Efitn3O+bdbXKxklL0MebYUhM5ElVqzs8qGf
        lyTxQvkkRt0m4SHkvE7K7OGBgNfBoO4WIExDwXOKpTWsJsyEn2Pww==
X-ME-Sender: <xms:pzWXYXycp3Fay17BuE5ru52vt0meaP0FJX386zATZipViVi_GJkHgg>
    <xme:pzWXYfQkOw20WzJ706K-otb5WZjertUA8VYiIY1LnvNLbApowSD35Zcls92pLv06X
    SsoPUgWVFJ_nV1G0Q>
X-ME-Received: <xmr:pzWXYRVMsmWznBkXtYsGoQnD8TXLSNWpE84DnU0F4zVXgWD_AJ-CfEL0nP5GBZD162RzWH1zmGRPQKR3VjzGHzJ-7RHf1jIiQTDn_om90bgabAwclXwwx0MeiwokFsTOMzduEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:pzWXYRivhBvJLwRKn0fELdFjPEMTnuxFKyWYVu8VSXAHugDr8-7KGg>
    <xmx:pzWXYZDhMWN-lzmKOkfIqCUkNPHo0Oc--7ozgnFag1_KcUQIp5jyZA>
    <xmx:pzWXYaIGi15KPcV2olHJvGjUbFOrmHmPyz4jwhTyE6Al5_KBCHWQtA>
    <xmx:pzWXYTDURwOJZjZX20JODuEircQYbtfB9a4EaJGd3uBptKkdIO1W1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Nov 2021 00:27:02 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/4] dmaengine: sun6i: Allwinner D1 support
Date:   Thu, 18 Nov 2021 23:26:57 -0600
Message-Id: <20211119052702.14392-1-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

D1 is a new RISC-V SoC that uses mostly the same peripherals as
existing ARM-based sunxi SoCs. This series adds dmaengine support for
D1, after fixing an issue where the driver depended on architecture-
specific behavior (patch 2) and resolving a TODO item (patch 3).


Samuel Holland (4):
  dt-bindings: dma: sun50i-a64: Add compatible for D1
  dmaengine: sun6i: Do not use virt_to_phys
  dmaengine: sun6i: Add support for 34-bit physical addresses
  dmaengine: sun6i: Add support for the D1 variant

 .../dma/allwinner,sun50i-a64-dma.yaml         |  9 ++-
 drivers/dma/Kconfig                           |  2 +-
 drivers/dma/sun6i-dma.c                       | 78 +++++++++++++------
 3 files changed, 61 insertions(+), 28 deletions(-)

-- 
2.32.0

