Return-Path: <dmaengine+bounces-5952-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C920B1AD5D
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 06:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE796621949
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 04:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2B218E91;
	Tue,  5 Aug 2025 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3O1Xs24"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179B288DB;
	Tue,  5 Aug 2025 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754369919; cv=none; b=FLVncG0MuOtTE8+fBzs7b2SnI8sS+YjDnTaWfr8eA3zrix3bEmq9Y0C7RbJam73AOXj7xQjnD5buRvJ44Czx1HWrmBh7ZzCvn6YEZerufhQN0yBMvcd6Qj+3cJoW7jH4WF1xlIjtJCa9hKT20tzTRU4DNNSOAMiaOrngTwl3IPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754369919; c=relaxed/simple;
	bh=p3Ctln5ArnuqEriQVMrjSsSycEXSlWingWpH88cmVVY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W1YiCk1fFqqaj0aubGqZ0J+YE8JDkOVJ32kQwSTLD+DWsVpFSskdFak31Q4Ihq3FROq/TQMYQOhmA8Q/6WQk8BN+DPR5Q/8+MdXwKijI0qfmpiXEM+1v9nq6BTkJdLMMGQt4PmsN5qDllv2lDsi9W+AAIinDOmaY7w23BoFIijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3O1Xs24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21656C4CEF4;
	Tue,  5 Aug 2025 04:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754369918;
	bh=p3Ctln5ArnuqEriQVMrjSsSycEXSlWingWpH88cmVVY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N3O1Xs243//hGVgduP9ucmQLc1mAU0+00JxEYL8S/mHxpbCYQj9YGa3ns+J0f+wbY
	 XvH1iHOKTKJttx+GFQiutBfSbVUixllJOWlSwpQmhdJK5Qtb/0LnKeJBdghiHojBuO
	 c1M5fhSZV8ex0HXNQYodcoubSS7yGINLqkaiXDjge2mBMnWefEE61tRyZK1UGo0sj3
	 M8tPxg5kUSxKUKr77ExSfJsg7eFUKrECodT5HIy6M5ai1LZ8JFh53r20tCF2YpO3pw
	 9irhgqipyxlolSqDyVR2cGCZmANlFRx9dfoJwEfgdC7Sgn+/IUi9pmf/bxqoLsRE3j
	 MUe8qchs9beJQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
Subject: Re: (subset) [PATCH 0/8] dmaengine: qcom: bam_dma: Fix DT error
 handling for num-channels/ees
Message-Id: <175436991267.243171.3381840472442505364.b4-ty@kernel.org>
Date: Tue, 05 Aug 2025 10:28:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 12 Feb 2025 18:03:46 +0100, Stephan Gerhold wrote:
> num-channels and qcom,num-ees are required for BAM nodes without clock,
> because the driver cannot ensure the hardware is powered on when trying to
> obtain the information from the hardware registers. Specifying the node
> without these properties is unsafe and has caused early boot crashes for
> other SoCs before [1, 2].
> 
> The bam_dma driver has always printed an error to the kernel log in these
> situations, but that was not enough to prevent people from upstreaming
> patches without the required properties.
> 
> [...]

Applied, thanks!

[7/8] dt-bindings: dma: qcom: bam-dma: Add missing required properties
      commit: e0e2cea86f75c8255b7da13ec92a34bb35a9c4fb
[8/8] dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees
      commit: 2f8a2cfd0994adf5f71737bb0946a76800479220

Best regards,
-- 
~Vinod



