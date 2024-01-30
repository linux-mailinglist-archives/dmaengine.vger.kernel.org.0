Return-Path: <dmaengine+bounces-902-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F48429F6
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CF91C23559
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693B12BF3B;
	Tue, 30 Jan 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsG7RcOh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27E12BF33;
	Tue, 30 Jan 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633469; cv=none; b=h8jU/rSWnSa7wwvOqP5GNQQ1Ib/3Sya+upu+aDvOpDPkAZPlfbTv9a82/QIISyW2Vtnezgf7p1xXGqDgqPkoem03P1LUqIv+gpPReS4hdCxuoSQHgaRHo9l6XKa2IBHnIN3hG2hWmy7cgzvyKJCe/KmJwl1sewXWlsGwyQ0SbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633469; c=relaxed/simple;
	bh=YWFtBw/iaQYPF3wlV1Nj1wmR8WgTfL3dI4u2wGOVhgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=coLRNZ/rSaln6VgQKfmSklNciOYDpWrae7gKtVNEjpPLV5Blk+TOBl8G6vJhPIWAMoHJBEKfCTpVDQfaZ/F9I0J7yJIi+bsXnQytpo/3XovW916tLaJLnC0VHtXQHYohOSWl+DuZJNovuVRLX/iMK8dQBCOlN/sbmVWpCeriAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsG7RcOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26614C43141;
	Tue, 30 Jan 2024 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633469;
	bh=YWFtBw/iaQYPF3wlV1Nj1wmR8WgTfL3dI4u2wGOVhgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QsG7RcOhRqztuiJCoOi1ub8Jp8pbsz3jZbQBghxeBkaGfmtHqqssTxJPvbQUkOiBw
	 956q/9cXG+l9Za2hrCnt3HyS+d0yF/lqDTrwNj8qJsx52prcG4hAnDNn98DEfJKOSJ
	 /hK/SLNTt1Lznzgh2ZIe6RqJKW17eg8AoBj2lK5f5WpLO85AqUMLkUNfzGUmUJMUpZ
	 y35Z9io3hP4RdEDCCyIzJ8xxNqf/wPhEG3d5VoVFIHopVTlMzVH46lANsvFbQP2qfq
	 P1QpjTWn8VemkP/L7N2yV8j/nI6SucRE7hvdiciFtS+PHu7w4qHKrbr+Pb9WGRRSL1
	 oH6nMAUvQPnHg==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Vaishnav Achath <vaishnav.a@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 u-kumar1@ti.com, j-choudhary@ti.com
In-Reply-To: <20240125111449.855876-1-vaishnav.a@ti.com>
References: <20240125111449.855876-1-vaishnav.a@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-j721s2: Add entry for CSI2RX
Message-Id: <170663346675.658154.5929663747178055844.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 22:21:06 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 25 Jan 2024 16:44:49 +0530, Vaishnav Achath wrote:
> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory. It can
> have up to 32 threads per instance. J721S2 has two instances of the
> subsystem, so there are 64 threads total, Add them to the endpoint map.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-psil-j721s2: Add entry for CSI2RX
      commit: 93bdff7bb83a9ea79f41d4e48e1711fd5f4ec4ed

Best regards,
-- 
~Vinod



