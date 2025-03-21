Return-Path: <dmaengine+bounces-4762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246EA6B69C
	for <lists+dmaengine@lfdr.de>; Fri, 21 Mar 2025 10:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF45C466BAD
	for <lists+dmaengine@lfdr.de>; Fri, 21 Mar 2025 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81251F03D9;
	Fri, 21 Mar 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="NmK6I3eA"
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DA1F03C4;
	Fri, 21 Mar 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548010; cv=none; b=DTenUHv8yqcK+T5Ti5pL8Hs5OlP/4s1FB9gadqER+pvLUMZKUoPZeacJuE0fscTEoVT97kPPQ7ysqTEPiozFW2wsRKbDC7gdMdkBg4iqeLZv6cJzCc7CmmpAbgOQ/OnudZH+/qv/4hfqdQ0U8j7F54LbEmAhX45nOUW3gZ6BxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548010; c=relaxed/simple;
	bh=nd7Hlijoo4SHjn4bvaDypRqs2ZkWHDVlmW2gwUcp7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGI2qo5wUMD6zTbj+OzX+Tc2JpFKr9S7LSUz/k2TEMxz7Z2KjuoE2kQWPPRVwisVYq+2sqNRFQC7GNe8161SY2/WH8XML89Njj/1YVMaoCJs0etLk5Y76S8VLqXhRsQS971LSlO8cErd/wRbRf0G2OY4i1PezaJX6nCkxLn+3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=NmK6I3eA; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DConofP6tD7c5xckB9jldT1Ij9v5gECOt17lWOu6Vm4=; b=NmK6I3eAcWD/vhe3JWXqBdQCA4
	sJ/nFY4QORYXGTkrDXfeUAQ1VwEfSTpjt6j3fQlzQCe7PAZrDUY3ST4iz/+NfvwJGVG/V9IJUgqkO
	8l96cE3GL68MMM9MMuQr5i4IZ6X3AhIufl9tBtZTVoN3GEgjTQqaoiNgy2LYZmtEzqaKNJdPlqyfT
	GUGIVwTw9aZC/d1qF8J548YPBQJNpZDRRz9rulw5iGxUjgyNJUySWL2U8A1hWRXapG0qSP5YqVtXV
	Osz+hhCckvcfzAvZNJLbT8yzfJ5hw4UkBwm3QNWEDKxQAQ+RNHv9vKUQirq1s25HA/XDhEex+zqWs
	2rLDxoCw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tvYKl-008ya9-0K;
	Fri, 21 Mar 2025 17:06:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Mar 2025 17:06:31 +0800
Date: Fri, 21 Mar 2025 17:06:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 0/8] dmaengine: qcom: bam_dma: add command descriptor
 support
Message-ID: <Z90sF_1SporNMdIo@gondor.apana.org.au>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>

On Tue, Mar 11, 2025 at 10:25:31AM +0100, Bartosz Golaszewski wrote:
>
> Testing:
> 
>   insmod tcrypt.ko mode=101

Please also enable CRYPTO_MANAGER_EXTRA_TESTS.  Those tests are
a lot better than the fixed test vectors alone.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

