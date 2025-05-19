Return-Path: <dmaengine+bounces-5204-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7415ABC355
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C59189EEC9
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375A286882;
	Mon, 19 May 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OOA6fHnq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343F1A38F9
	for <dmaengine@vger.kernel.org>; Mon, 19 May 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670276; cv=none; b=aTG42bOHwIoGkb6hrHXYtHmxqjTRSy5NgXgfeb0GVmUXZX2rP51nR1UYla+TudT7UToL6b+z7Qyym/K/cEGaJzJdQmoXNLqfESoV8I5F0rmf62Hesp3WIa1zidfWbPpkGtJ8t1T1x74Kmt7zjpMog732MSUaffaAGjfK1UrnInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670276; c=relaxed/simple;
	bh=kDzZH/2//KqHjtRhP0MAmXrUXCabtr3kxzCKj86U3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYgjlfT8PY1rDevxNgbAdL8EsKiKYj6FmnRIO8eub6A195zHaD/UjL7ftZu+gIC+vR5SQmaYBBpdFhPErB1X3VrNM5zHOpNZcWihqXZBIAxjbXvk3E1rQ1VxWI9Wm0IiYT/elAT3eKuPY1iyR/nXR7Gr8zbzhMQcYdCH3FNxxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OOA6fHnq; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c40235c34so1528306a34.3
        for <dmaengine@vger.kernel.org>; Mon, 19 May 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747670274; x=1748275074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNI7NcwENluO3zokSTsjvdClRmMPUb+KHUbQq6ykMN4=;
        b=OOA6fHnqrd8XpwQtTyQdHYmaSZpFJumVIbFkClc705xSbXWIGCW+QbGlkICp9cyLml
         HVoxuLjaMzrqxhGyKk0Hjs2Dp3Nz2hH2mtD2ilAx+4oLfzCewT7oBaHGW0yhr+eESPqF
         YT1OUyeXC18C2xq6s3wIE4dNZWqWaM9132fBM8KaqGSl1HAPabZ7gQsamyG9G8a06NF5
         YBq3KW1tquKYGwoaNY/QfBBawFLbQUg+5ckpO5HL7m2gpJ/OKZy5tiBPyLWa+iwU4/Uz
         t2T9JecbqPwLdAekw468cBJBEZMMtnDRM+d14VmSZPyUlxVj91uc80sicwP3xAW+WWRp
         VvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670274; x=1748275074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNI7NcwENluO3zokSTsjvdClRmMPUb+KHUbQq6ykMN4=;
        b=v6c+16JSUH0zTgnCKPQ9vXxapM0UFI7Bh6CJZlx+i0a3GYCc37ww8wA/CNq0I0nCA4
         B5jxtZFNPiL/cGu8KqQiU+ktjKopMS1Ikx8YPTPPZ8dEz154mzH11yvSw8R9UAmmgjlC
         5qdN5s+LqIQii8HNRYRGAVhw32cjn1NN1m8HyYig9KE6CetSSel88NHgRCtZvN9y9tXm
         tTqJN5m+ZlEx+1F7IMNO6269dzy/XtA7ETAXzqYkEqb7WDuc1d9/zlXd6GTdhS5jZguI
         1n4t9AdaGQqFAvnFa8pgBRoBu4g1rWnLL6UmRJqmkGda3yZX3Do+G1x1+9iz+YAT8DzM
         wzTg==
X-Forwarded-Encrypted: i=1; AJvYcCXf1tEL+WmAMRlniBhvxJDVs2c4cpH8pO8L/CIQNXhtogra/ZhW8g/ayDeLw/6toWT8k13GJqxHKv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jg93nUQI7D/G4VhWvx4xD0GNrbhnN14hXsLx/hVmb2KpAa88
	5szT82MbA7s6EBQmxUjDJS++TTD0f9dxxtvu6+I5AmtZPtaq/I0HpYDboLZt01xvpcs=
X-Gm-Gg: ASbGncuZMieOM1peG2pPyrdZ3A3h5JYvH5V7sYrXt3fyEcu23awTfpOhr8xFKyv2NUY
	vGKUog+UN8//pDdPHTtEcL45Wo4Z4ik6HCsW83vC+xgUtGWbnKk0ixPDGCU+p9o44wCJ4Dwsh7R
	2lChXDytJTjP5VuJokG41KmeI4vnlNWANNQkFzl1+cJ3Jpet5/MZO66ytpcyluYM2zk5rQ8QE6d
	kEWPsA/f3jCe99HZXqk5UIq0Sj7VKP0xR/blOJc+XEHL9IPiuVrDSpzIMwU8lzr4Fxt/qXgHBlf
	BwqNt82UPhGdCFAQQuv1MOyPudBWzd1uBrO59OyeRZ4kU69ISE8s+kCw1RV34P7pdZ2b09djyAa
	szIhaGeXh9iqAm7NgbRyOeiuYjw==
X-Google-Smtp-Source: AGHT+IH8T8zg0xomQN28G1hezc6Z1gZDVp2eCOEmtHqiL0f9gIeNGI+bpJuOCxDdS9NlFECubITNsg==
X-Received: by 2002:a05:6830:61c4:b0:72b:a020:a2c0 with SMTP id 46e09a7af769-734f99582ddmr8068793a34.17.1747670274203;
        Mon, 19 May 2025 08:57:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b5f5e7sm1463565a34.65.2025.05.19.08.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:57:53 -0700 (PDT)
Message-ID: <adc2d646-06fd-4a9a-bebe-99d2a6cfd2d5@baylibre.com>
Date: Mon, 19 May 2025 10:57:52 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] clk: clk-axi-clkgen: improvements and some fixes
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/25 10:41 AM, Nuno Sá via B4 Relay wrote:
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
> 
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


