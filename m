Return-Path: <dmaengine+bounces-5108-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C286AAF520
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 10:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FC31BC77CD
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31F21D5AF;
	Thu,  8 May 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YCwYQMd9"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285915748F;
	Thu,  8 May 2025 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691580; cv=none; b=tjZ+HoLEHdc8jSOGVm8zDwuf3xe+SRHkEMzkbhezsc8npwBh6rtLXOXNCyieGvUJie2VRX8yGYygoKNEiVVAwErpp1iiSH6fcnfyOD1socsefuSgpeMElRXSNx4d69RYAiKcV/POUj6PJO7DWCgzRC2fF21XBSDe2PHNDa8kS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691580; c=relaxed/simple;
	bh=ZPSaHnlBmfL989bwMg4ZlSVegQ7uQgB+oa4cG3z5HbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOwb97HOuloiT+zCrimKipJt7+tmiZemZ3vuBE+f+NsAfMEFycwYIwr+JjjgrjiVYKL2NqUliXKzv2NRzlFs6ee2ug7LJmQq/3PR+W6gQxtfp/+crmS9Sct6yFlAPEUWWNXlQ2reVrYY8BBaOudnvRCQxCZoIGgVFb7RvyPACWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YCwYQMd9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746691574;
	bh=ZPSaHnlBmfL989bwMg4ZlSVegQ7uQgB+oa4cG3z5HbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCwYQMd9nunF9QpMZjc5MxjW95bgBcb85rbW9F+aY0V8MAL5G7M00D9HhSElzI9T8
	 hCskk2oIqljr9N61RBRuzKStTv+ojjhGKPT1l0n+HX86ITnD7qreGM/Afvb3sU9DsX
	 rpF0b3j/jt4jnQST4oOZbWBJuWnLpGM5HOsTSwinSqVGXi5S0kj3d0ykEcyIznorp5
	 psS8qjwj9456qzway+841+MvwYKPi8AbKqYZagO4QYrc5PYMgj7/IDtIjEWNwOyVfn
	 1vCm7JWZ9vSPP+qfmU30g0f+x/ER17M2aklGCy3ZAlxsp2DtR7qCryUQzzwBmaXRi5
	 Bi4+hTskYK3Ww==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A34A17E0C0A;
	Thu,  8 May 2025 10:06:14 +0200 (CEST)
Message-ID: <fede9d2d-6225-4760-8920-c5963665ca1e@collabora.com>
Date: Thu, 8 May 2025 10:06:13 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: mediatek: Fix a possible deadlock error in
 mtk_cqdma_tx_status()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, sean.wang@mediatek.com,
 vkoul@kernel.org, matthias.bgg@gmail.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
References: <20250508073634.3719-1-chenqiuji666@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250508073634.3719-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/05/25 09:36, Qiu-ji Chen ha scritto:
> Fix a potential deadlock bug. Observe that in the mtk-cqdma.c
> file, functions like mtk_cqdma_issue_pending() and
> mtk_cqdma_free_active_desc() properly acquire the pc lock before the vc
> lock when handling pc and vc fields. However, mtk_cqdma_tx_status()
> violates this order by first acquiring the vc lock before invoking
> mtk_cqdma_find_active_desc(), which subsequently takes the pc lock. This
> reversed locking sequence (vc → pc) contradicts the established
> pc → vc order and creates deadlock risks.
> 
> Fix the issue by moving the vc lock acquisition code from
> mtk_cqdma_find_active_desc() to mtk_cqdma_tx_status(). Ensure the pc lock
> is acquired before the vc lock in the calling function to maintain correct
> locking hierarchy. Note that since mtk_cqdma_find_active_desc() is a
> static function with only one caller (mtk_cqdma_tx_status()), this
> modification safely eliminates the deadlock possibility without affecting
> other components.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bugs
> including deadlocks, data races and atomicity violations.
> 
> Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


