Return-Path: <dmaengine+bounces-5980-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F68B2060A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 12:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DC7179CCC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA8242D60;
	Mon, 11 Aug 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4gIi4V/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FCC237163
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909214; cv=none; b=VqVmr8C1NP3L0MwHugD+v3yU+QU4oF85RzVvonl36OQyX5MvQCW4pWMvLb/3VAig2RnJr+MVhU1B5cRZ73W6xyR8/XC3ckeFW4CxY776rEPWtBzzRnPH8rXUPPSsf5QRWU3eaVVOkVhf+gCgVAKe0CyBwYVvMJzInXhPqsDZqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909214; c=relaxed/simple;
	bh=KQjwCDSr5jTF/NVTREyzCmEWp0l/PPEJli2cAxTuyEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcLrhr6r+Xab7/SASl30kaXUONSfJwTaWGJ8lwO/vXVwtkYgTU2m1eqaqLxSGs7MIP7+4Mhi6X7s5TvsD8H/Ls+n4rFifqnE6vPFws7qL3RN5+PFXU0426AspaaZMS1SstHNjjlkTe2tQWxoVThkgUYpYgWqIbNAJPCLGNMYEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4gIi4V/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7910123a0so3906995f8f.1
        for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754909211; x=1755514011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtlLyamwVwRjM02auBJdL15wK1iRYbhmPTYPeAKkJwI=;
        b=P4gIi4V//S7bTvnrSDnZHHsdev+ZeWw6XeLLEqrznSy03dNjB0KQNo8hERHpw0bXGq
         ot/cG//W615H9nwmjMZB7LoExvo66ppVyFkyDX/fq61akCdcahmLVFeLw3yMHVn+aGyJ
         rFgnlGS+eDr9XHFst/WVZVh5rxCQp28qBRuwiWER7bjqSMF151l8gULW79DpAcAzh97n
         0PsIGKpZC8un+jt/MhDWTPOsBEiE5uiRa6iktpRFmHrxwX+d6VRkbcoMGl62kXWtR4gZ
         luY9iKHHPtufetwe593vvO2ZygEZboCx42QyEQgoS99oUrIxyj+BXCWx8SQDJbfhI5Zk
         eLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909211; x=1755514011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtlLyamwVwRjM02auBJdL15wK1iRYbhmPTYPeAKkJwI=;
        b=t9+FOnjRIPb8FPLhzvl+9+JcXAwRjmCdxLob+9pky7IUx8+QnQ9kOluMBiRTq69XZ5
         NqIgNtsYyGZDquNfwnpSMEu663E5l5rCoLhWdnvBDwtx6cG+bEAlKmg67ha7PPK3XPvS
         5m8abIEl3u5u92mgkZ5jhlAXYYHhUOUt2M+Z7SwLEzbUQ5FNlEioVnHWJILwfEngTez4
         n3d4QBlGMv6dFcWLmm2H523LdU1D54yyFfZ46L3zsjeHiTQ69CgKeCjIkrcU2YewZkGa
         bKbKHkGSVXtqNEdx9qeGm656Y45zkZcl8oa2U63HZcawmYoN1jEFAvgLJs4CqTZk60jw
         lNZg==
X-Forwarded-Encrypted: i=1; AJvYcCX86bb03ry5/bGXFV/5CekpymQO6jnZOzIWxgsxegrR36C5UU5XTHZByINxTWUs3o0gKK6n7pF8ldc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIz358MIaLswwLwsWebNTxXxirGcddq5mYCi4NmvfG3/YIk0nS
	r9+OBmMFFIDnn3Y5PM/1Zm3zYT1X70cWgP5q84c33j+v8JueWS9vo7cO+07DhkcB5uY=
X-Gm-Gg: ASbGncu3H8kXbsQY1Zjs49uoudi7kXiW0vwYhc159QxEHGdH94Wkg4dGIDX236I2qRX
	iBUAYEhSp983qJKMfnBwA7NxWslVyyEA4oXvKJ9PSlKELw5bWsMImzamaWzQHCYaEWQKnp2OgHb
	K9VqfalLg/LfaIQ1g4MIOqUlWex/u1YbpGlzAo8Q6OFbd3wha1njtvJwGcFmG4FUYRZPCGVImQU
	PKGXGzrPEg2EtYTqjOfWvGH/hWwFhOoRc/xoXmuIDcz3NZwhkrunCVpRorh/+LHgbswoOXLx0yU
	LZZpRgbUO2pT6S+QDh/18JUHlzHcUNWdwLpzf7KTlxnQt9pNsrOCC3w7oF3/+PNZxbNNltymyWe
	XiG+6WpsLRmM83SgENNO1EB5tLzo=
X-Google-Smtp-Source: AGHT+IEqVTwXhwTo7wvqPa+EmRjt/aKNN/yf02N51BBRSP3bPmO4761RJTTOJAX9B9e1QYT6x1ySSg==
X-Received: by 2002:a05:6000:4305:b0:3b7:76e8:ba1e with SMTP id ffacd0b85a97d-3b900b4bf24mr10266286f8f.11.1754909210556;
        Mon, 11 Aug 2025 03:46:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b90fdc85a4sm898125f8f.60.2025.08.11.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:46:49 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:46:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix dereference on uninitialized
 pointer conf_dev
Message-ID: <aJnKFa9YHc-pYori@stanley.mountain>
References: <20250811095836.1642093-1-colin.i.king@gmail.com>
 <aJnC8CLkQLnY-ZPr@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnC8CLkQLnY-ZPr@stanley.mountain>

Actually the error handling wasn't so bad.  It's just that one error path
which is buggy.  The idxd->max_wqs variable probably can't be <= 0 (I
haven't checked, but I assume it can't).  Anyway, I've sent my prefered
fix but an alternative would be to do the below.

regards,
dan carpenter

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..b603d7dacf3a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -195,6 +195,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
+			conf_dev = NULL;
 			rc = -ENOMEM;
 			goto err;
 		}

