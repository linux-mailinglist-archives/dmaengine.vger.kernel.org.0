Return-Path: <dmaengine+bounces-5825-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A21B06166
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17374188E8F1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405028468C;
	Tue, 15 Jul 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2v2bzED"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0D283FF2
	for <dmaengine@vger.kernel.org>; Tue, 15 Jul 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589820; cv=none; b=ELbjyxfQs0/AmIoCoscvgCmUwd/zzue3HSWn/aliRC1Gdl3+U45sEMaEbNTywig6dfOG7pO3J3ga2xyyF8xAe6Mlkvz2kknNzrZM9ldjT33h9Yq+7N5dGWDx3Fp7Ptt8RVBl5pedNhpjxV7k87GHHIpAyJtSVveqIQyXAfr1owY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589820; c=relaxed/simple;
	bh=FdL1/HKNTpO4kdE7n4NKm5VaVSkDlbNs48yc+1QgZas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J92g6UNh6sHCWUlUdpAh+HmGzSFmNrudVtTyTYos/rZyATD8asHpPfP+Y8TrsXx7lpOUkBFzGfHAC5QjU3rewdn2wOlc17ZXFirZKOJ32G8RAG0dMUa9OfAAsn8A3R59u7ESVdYdNwkh3tcGQh/afAfJeDB5LnkykfjLtYbIYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2v2bzED; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eb00so4628161276.0
        for <dmaengine@vger.kernel.org>; Tue, 15 Jul 2025 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752589817; x=1753194617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=W2v2bzED3A9ejC4TfbgBBjzjno/K1PhLK2E7O3e0SPUbLWqTR9Evxz9A+K/rXmm1Gp
         Et22K0hwMJdya3IKeHHsXW3hPwxvGaAhOYHBmyAS8ncFcpUbQerWd0RUW9AbdeTrB6sG
         QOUikyYzPsid/y34PVziDdUyKm1BoNauuudY42lVMegWroSPQOo3Qkr6ygEYUTk7hnPm
         kY02nYoNhhonMX9fIknHS1fRHnqETyvy/jv6p/jTCFbethMcmYb0L5oWZWuzyDkW6sow
         OmLBsjvk6glkP806VpmbDr5DbkxrIKVAvgata5YVlC/7rRECoPR3Rnlb3ulchSSzVxCG
         mZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589817; x=1753194617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=wMDjjbMjL2r6tF2DZVwgdFFVa78PcjjtSgg/bmB9bsB3By59WCQPd44F1jrnKkCm7v
         MHn5z2P+ql7i3JASNO9Sj9BsShCbUFvU5tTltybNwvjMUi0PYXeMS/mMjVl33FekGpeT
         b3AQRimg0R/ELSuCmL62An9SRVhg2iOr4ZbwwIBFmrgbZh4zmLzNGWk2ekuXRWnPnXle
         vvV11DHbbJm59pVrSnsqwcwr9YmvSU2S7dUcY5+Btlt9PB3omKOFoN7acRSumhrtcdQF
         Lcy2CpRBrKTU1DsPscDMWeseDhBSz+ulUR4HTWBZAqwYdxZML6khVPwjsxzj/J9e2/4o
         aIag==
X-Forwarded-Encrypted: i=1; AJvYcCU2DsGY3aL5gV1TKVbCp9FI8RLQpxui4oB2i18PJa3PCi/OlF0eOyedP94gyUVAMtl4KgNAMJxtooA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nbhfoDYbILQWPN7oeLihajWlatYIioabiAmbZPXrybjfENwT
	OARFeSv2PC5IfN9j7Q0OF6UvyVPGb1AgwshhRPQGU5mcrh79qdUBL/5jwQ8IRvIbF6590ud8U/v
	GAKS1JYKGV275fn/aFgfV7o6M/+7MwF4sXRlNEA5wOQ==
X-Gm-Gg: ASbGncvSmb0LB4wvQib+xyA16dyXP4a+pwVIsTSyLCRpyycuudTJBmCQBF6Iw9t4u7j
	iexy5cUkTCZdKY0fIBtV+0x8cUxo1X6tVSelPmimQpGZ08peaMnvYQx6JuZsE+Dh0t/be2XnbTi
	OuygS/9XD238S53QRd2DL+/ukTZcWnA2P7uWFcscOQY2bPBlQ6JxV7Z8uCMP2Zka8hWHq7fg1OS
	u0qDBKX
X-Google-Smtp-Source: AGHT+IGBzBhoCXe5OGunO7xvl2ZbN7LRPwWWQsLELIyQWERT2XuyowSM7Ti1rVh+eETJFMAPU2ltq9fvUbOvfY7jIrI=
X-Received: by 2002:a05:690c:9:b0:718:2387:4544 with SMTP id
 00721157ae682-71823874737mr49946387b3.12.1752589816638; Tue, 15 Jul 2025
 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com> <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:29:40 +0200
X-Gm-Features: Ac12FXwmHbA2nWRNuYQwrZTMO008mwPCFYz6i2upkNA2qncGOOVsk9AzGvxKlLM
Message-ID: <CAPDyKFo77_0n0SefZ0N3osbSM=0tXW_rsjd9P4WaqoZAwyaTGg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Jul 2025 at 10:07, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Document the SDHCI Controller on the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 2b2cbce2458b70b96b98c042109b10ead26e2291..6f3fee4929ea827fd75e59f31527f96b79b2cca8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>                - qcom,qcs615-sdhci
>
> --
> 2.50.1
>

