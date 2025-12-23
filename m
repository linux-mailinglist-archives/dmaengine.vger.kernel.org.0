Return-Path: <dmaengine+bounces-7875-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DCCD9173
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A79300F5B5
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137D2EFDBA;
	Tue, 23 Dec 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ+M0Ad2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F232E6AC;
	Tue, 23 Dec 2025 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489029; cv=none; b=VkRV9z+5Ue8ERrcVu/avl04e13kYKYnmKI8n8FsKm+cLfQNydO8xb4uWYxLGkjRW8UP65opRWz1wEc90+ZuD/voX7HZlH8WqjEgGI7wDZEtK/9v/jV5p4ZlgKZrn+WYno1rFCT+B+B9oXuSlNTFdGeZLX0vRa36RFvZy1VJwp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489029; c=relaxed/simple;
	bh=xOFJdug+Q6GJhP8aZlEX44rWqO/E5ErGFBPB3YTE1II=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b7pxVw5MLhUBme9UlwsI9fleV9ew8NPcWIKQcd7wOEztkPjziD3DQt7IIDywtGIC5Tt59KIFWrbAcfuzX8Z64TWEf05NYxxx9COrwx0rByGV3hvIR/EaiUiUeI5ojT4ZO8Pxpu576Ul+M+hFayyZ58ZOQp2F2gZcZ6hQomwx1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ+M0Ad2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E75CC113D0;
	Tue, 23 Dec 2025 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489028;
	bh=xOFJdug+Q6GJhP8aZlEX44rWqO/E5ErGFBPB3YTE1II=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YQ+M0Ad2Wl1Ra6ojiHVvDUSX2VO8bSvZOQaPWOSBm7t2qcQgMXbEAmeyHEL82arsE
	 f2hylnkp9Sd9NdKfZAzgqkFi9XSz6qlFZSJmVtFjorzBdvjHBlR3CalzR7QQ0OqALU
	 LccEk7hetpzvU+q2OFGockT7sy8ob9ph4O+jI6vLWIs7iDrgHmSWCRsxgJ0Rr/gns4
	 wVcJEfF/y2kDoeZJw1aIxE7Eefg4JW/mzpk9oHf88TB76kjK4OmmWFrhXe8ANMGlex
	 J3Li4bQonRZ89tCkgiuv7QGQOgf+vqQc9JeYQY8/flAqeCSfdxOmDYtBIV+2ctqILy
	 F3VcZ/fiXK/Fg==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20251029123421.91973-1-linmq006@gmail.com>
References: <20251029123421.91973-1-linmq006@gmail.com>
Subject: Re: [PATCH] dma: qcom: gpi: Fix memory leak in
 gpi_peripheral_config()
Message-Id: <176648902567.689692.17832281669717772537.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:53:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 29 Oct 2025 20:34:19 +0800, Miaoqian Lin wrote:
> Fix a memory leak in gpi_peripheral_config() where the original memory
> pointed to by gchan->config could be lost if krealloc() fails.
> 
> The issue occurs when:
> 1. gchan->config points to previously allocated memory
> 2. krealloc() fails and returns NULL
> 3. The function directly assigns NULL to gchan->config, losing the
>    reference to the original memory
> 4. The original memory becomes unreachable and cannot be freed
> 
> [...]

Applied, thanks!

[1/1] dma: qcom: gpi: Fix memory leak in gpi_peripheral_config()
      commit: 2387beefdb3284298e98369bb886584e3abae4ed

Best regards,
-- 
~Vinod



