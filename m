Return-Path: <dmaengine+bounces-4354-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20897A2D617
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC5188C7A2
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F1246330;
	Sat,  8 Feb 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQTmfNbi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FE2451F7;
	Sat,  8 Feb 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739018546; cv=none; b=EGxfF2CQ3NLbYyLslVTzYW7cQtqIzXi4DtkEIThehAuT2yb9QwqBFE0LRn2nOmKYpbkXoSev4l+ZBPVp8pi++JgpLqR1a8EBKsRGvNmgO58ojnWotyiDTReuGwzSi1e9VLQt0Rc/dg+D4Dl7IQO9uWY99tvfs9+v9W4fgzr+iBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739018546; c=relaxed/simple;
	bh=8+vNZ6d84M35ihQAL4ODrnR0bTXDuJyzFILukAohueE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0TQjYww0aiRHxorZlWv4Fp8xsRi4b6OCeH9cLEm3zFg+5bS6O20/q12pFHugCjFjyRVtJYRLTVyWwACDIqJ/dcRLF5rkdt+GZ6SmDARrdebouHu9Cb8Ea3TIjHatPj7HEaHB5r25cIobXOapm9frfYFRLlWHUV40qKfYUtoDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQTmfNbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DBBC4CED6;
	Sat,  8 Feb 2025 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739018545;
	bh=8+vNZ6d84M35ihQAL4ODrnR0bTXDuJyzFILukAohueE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YQTmfNbi/DQpRUnZUt6exBi4BWNf220EK6sjGTlAzkyUGvbIH2dJDhXE0QuBpE1ww
	 ayMSUe10kKIgGBYk7+M/BGNZdAXxm4Op6mcRduRCOdNAJS8zzFibJeIqaf9zO6D3NL
	 yeZvB8A/WxFnoAzMQvb5S1j+aBpSjEPYeYAbfZsX3/B12cEhzxvZBch2/cs2qTnjHy
	 XVT/Cey+XaFB+m9b/ko/1YhA5+/THm5ulqgEtjbreBgvCx34IYm0g5RrP3d0YVpcao
	 h6mXHbgRuR6tUL8otPurR7XgLCxrwN9B6jJ2bJldEtCgLa6Li8AAmFHRNsC+bRgnuP
	 Agix9fdGWOG/A==
Message-ID: <0892dca2-e76b-4aab-95cf-7437dabfc7a4@kernel.org>
Date: Sat, 8 Feb 2025 14:42:20 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Avoid accessing BAM_REVISION on
 remote BAM
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250207-bam-read-fix-v1-1-027975cf1a04@oss.qualcomm.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250207-bam-read-fix-v1-1-027975cf1a04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7.02.25 22:17, Bjorn Andersson wrote:
> Commit '57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing
> unavailable register")' made this read unconditional, in order to
> identify if the instance is BAM-NDP or BAM-Lite.
> But the BAM_REVISION register is not accessible on remotely managed BAM
> instances and attempts to access it causes the system to crash.
> 
> Move the access back to be conditional and expand the checks that was
> introduced to restore the old behavior when no revision information is
> available.
> 
> Fixes: 57a7138d0627 ("dmaengine: qcom: bam_dma: Avoid writing unavailable register")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Closes: https://lore.kernel.org/lkml/9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org/
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Tested-by: Georgi Djakov <djakov@kernel.org> # db845c

Thanks,
Georgi

