Return-Path: <dmaengine+bounces-6535-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA9B596E4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DEF3B3BE3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF00303A13;
	Tue, 16 Sep 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QAzPxopU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9721FF36;
	Tue, 16 Sep 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027876; cv=none; b=VbNq+ZbPQeGh9VWRwS4lv0tjdwL8+nUMHkTWfg+J9VNhaeQs26w3jnVyLLIPlZOoOqz9xgOJKwaDdr2UqxQx9Va8Ej2sscXD/KupVeugvzrc9Me9J4g3CM4acO/J2Z5zx6G0L3eiIMTlz8F4XLTksCmG7rZp8Cl/KgseBrl3k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027876; c=relaxed/simple;
	bh=tS20RBq/5YBvw3V2zFuP41Ek8dUvJbPHU1ztOuJGWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oePEPloFxn9i+Fbf1Yq0c8KrBmxLnE0cK6YkcWoMwY42AqkekURsoK15WWU59J/D2ojO6c1f2Qfr80WBh4rZzZs6Zd2KsmaunOAiwP6DDsMpVozLtFySNKi0gOS8rXUuAzng2DOIt/yB9ueKV/tQcIr1OGQADCdKvkuDGRkDR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QAzPxopU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B43871A0D4B;
	Tue, 16 Sep 2025 13:04:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 855076061E;
	Tue, 16 Sep 2025 13:04:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBCB1102F16EB;
	Tue, 16 Sep 2025 15:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758027871; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lk9reX28fgXmqtrcSWnzyrJf4leAzS0Oqmq3V9099O8=;
	b=QAzPxopUaCqGJfJxbvhel1zBoDYowwag6/mUM+1aIgzoLiR2dD/svnDN8V/tJxDBonWSDW
	QCvUO5ImJ9Z+S7AWCHY0ECqZqAj7HUC8XGKjykpvLxHrJ6Xpt7OuijdkgSHLwUGSi1+qd8
	mBYkD7AThix0Ag3viWcjUWhjJPBTEdeHR75DpTjc1Eh8olLFdfslUt47c3CC6G6cPu+un4
	AC8idDTmmIAu+u47/HdsIzKF613zh7EC/iRM3V8pSfZ12QVa41ZSgLr8QElp0UgZ1g8Vr4
	yfQRr82Tv6e4o8zqc2Jm8roR+ZOytf9wQUlRJYsmncSCnbirB9CIEFOce5JpGg==
Date: Tue, 16 Sep 2025 15:04:16 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	dmaengine@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-spi@vger.kernel.org, nuno.sa@analog.com,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Turquette <mturquette@linaro.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
Message-ID: <202509161304166bf210e2@mail.local>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
 <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
 <175133153648.4372.1727886846407026331@lazor>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175133153648.4372.1727886846407026331@lazor>
X-Last-TLS-Session-Version: TLSv1.3

Hi Stephen,

On 30/06/2025 17:58:56-0700, Stephen Boyd wrote:
> Quoting Nuno Sá via B4 Relay (2025-05-19 08:41:08)
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > The adi-axi-common.h header has some common defines used in various ADI
> > IPs. However they are not specific for any fpga manager so it's
> > questionable for the header to live under include/linux/fpga. Hence
> > let's just move one directory up and update all users.
> > 
> > Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> 
> Applied to clk-next

Do you mind providing an immutable branch for this as my i3c tree is
introducing a new driver using this header and so it is going to depend
on your branch.

Thanks!

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

