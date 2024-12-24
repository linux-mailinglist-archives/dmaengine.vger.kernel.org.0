Return-Path: <dmaengine+bounces-4062-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A519FBC93
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA3B18817F4
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB81B4F3E;
	Tue, 24 Dec 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FubhPi5U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFF1AFB36;
	Tue, 24 Dec 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036921; cv=none; b=Cl34rbI7wrlBuxNuff9PrxuESBSL7kJ0zMZD20Z+QtEg+poL+i7u2fgIu6zGt3RAZpMtXzxDJx+SkBsZc8ThRsijZfV5zU3Fjv/BY4Fag/9Rx06sG854v3atqyWy6SfMCuvY3PisM1vGn5W0bTvAiHd81PCoRrZDY70owfaqF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036921; c=relaxed/simple;
	bh=Dz4SVX2xAASKtv9jz6bwakIaWNhtPb0mwMn/25ivMyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KD2GGVCXf3dohbnX852lEP18Pd393DN0wVgAAC5aKveIvWK04YrVXLEs76vKx1EcCIZrzlzxuVJKgtEtjkF2Mfz+oK25lz1Lzu5qIqkcxKa8eX7KAKC+McAFYr1uQm+iCmKiNMgbP0ApPkpVEHlqp0IDB1l1O9+CCuSTTkBmc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FubhPi5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7AEC4CED0;
	Tue, 24 Dec 2024 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036920;
	bh=Dz4SVX2xAASKtv9jz6bwakIaWNhtPb0mwMn/25ivMyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FubhPi5U88cf0V03e5Xh1m1OXSMmrhicVq/QFQE2bU4U4WiEdfu09gWY30otvsANc
	 7cx6iTeqQ+d/PooBuTULAt3MVHBdQ6WvGOyFr6/oNvY9TClxTVgQ2FGecl31J3HICI
	 ug4BkdPBRWsED20Kt7fRO42G49gRZyf88Dwce94yFFzFcPDwQ+ByQIrIPb/D0RNLC3
	 Gl0RL5lJULP7xuPLCRqeXdvDP+oGA5tQ76iDWYe++dpdJn7BeL1+h4s8mPGVOQhkvj
	 c8+75Kz4KFHdfhwd/sY/4bmB1opg7jGiqvNqyDJuvSUVdukSJl7qqNo+fyEexyJLvk
	 q+Ak9urVqpwRA==
From: Vinod Koul <vkoul@kernel.org>
To: robin.murphy@arm.com, u.kleine-koenig@baylibre.com, 
 martin.petersen@oracle.com, fenghua.yu@intel.com, av2082000@gmail.com, 
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: quic_mmanikan@quicinc.com, quic_srichara@quicinc.com, 
 quic_varada@quicinc.com
In-Reply-To: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
Message-Id: <173503691713.903491.236014957366551878.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:11:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 20 Dec 2024 15:12:03 +0530, Md Sadre Alam wrote:
> Avoid writing unavailable register in BAM-Lite mode.
> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
> mode. Its only available in BAM-NDP mode. So only write
> this register for clients who is using BAM-NDP.
> 
> 

Applied, thanks!

[1/1] dmaengine: qcom: bam_dma: Avoid writing unavailable register
      commit: 57a7138d0627309d469719f1845d2778c251f358

Best regards,
-- 
~Vinod



