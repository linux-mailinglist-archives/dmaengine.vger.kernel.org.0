Return-Path: <dmaengine+bounces-1933-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51B8AE995
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34651C22FD1
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA145C0C;
	Tue, 23 Apr 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMw6lgNr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B81B94F
	for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882759; cv=none; b=E6tH0jiGL1oRbYzq7HknowMTV3CFeTOoJCPKbAuyWtVE+jys2FnVIJKy1YoiYBiZSJK9BqcuLG89/uE8EkfF86BNPnbyFhLXEIjW0oEaMyfYXXgDsRu6YIddeT0VZyaeiLwVco0dwqPAKfg+TwPXMnsKqMPNFqAsMND8LFY+wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882759; c=relaxed/simple;
	bh=JWM2q6UKkmz8H/Xpe/GSq85B4GCozLjkupEY7UIUvRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JlNwwMgfx8V+dQbbFFzg1Rz5S5rjywSL5Rn0q8RoJI2kYHTBVT02Asl99RaA2gnsYtdFJrQ1gsNFs99mLx3+SOB08sniGMbd/2neGGF85Amqz7JaV9uKchOhbhnCyfAkNMv2OYSFqmUSYl12DRFG+Z8viaZK6ZwRztZmdz9mznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NMw6lgNr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so4999260f8f.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713882756; x=1714487556; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZEaYbNBN6VwiEMjZ9dxH2E1jE9IWjAX6OUPtgfdueE=;
        b=NMw6lgNrJ7maO+GOULzGCSZXkIuvyF7PDbxcFnLuGmlsv501uiteJ/q9d8YmoRPX2U
         to3DpK8oayB+tURMz3xkwDf4K93K5l00Fj6+Q3h6YjC09zIzVspPJLs910Ii2hfgflra
         71fFChwP2YJ7QUjb71bLL7AX3DFiFjH98HOlCDGfjTq3VyTzCrBV+rNvf/RiYU/vMfw7
         7I9kYwRzCDlly1byno+9XpcrsO6+/YADmww4LQbX6IeEnUc/c5sRjyKaDUQPPVqo1Mor
         mQhB+ZWooPUWVVF7/RpHzxRRq4SN7FjwWafcPuNXGAqsTORQ3xmnQzhtnkDvUssAS52E
         Mfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882756; x=1714487556;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZEaYbNBN6VwiEMjZ9dxH2E1jE9IWjAX6OUPtgfdueE=;
        b=WwgHjxWRyKjltm6Viqt48icynq7lJCtv789Au8BaA540oeXBsqVvu3Q5c4YfVESXqF
         CVHknn6V8Q+z5pgHC4FXhg4vYw14yfYDeOMEtnmOGtGZJIS8df+IEZJUQEzhF2HFefLq
         5Jy0cMEOeiHAY9dPUfrkrW41EzLYsmuaBg+C9TCifZUdnI9BJ8yVOHv6koQDUYYa74he
         51uV03SFMetCGbppXwm4YCOpzhxY8KmBIQnog/hQ5m4Uf4BpOhMyzXsdOxHW1aDMZK4+
         DW7bxmXMhWk7dvZjvNu7zBVIzcTkZqjtKLgZEiyHYbN8ddDuiVMfxBkEs9JczwYeVXQc
         ndiw==
X-Gm-Message-State: AOJu0YyvZCcRDhJgzUkE6pEQ6BznBCG51RcRpPqOjaZ9qyPwRqT3h9/b
	abJk7ou0mdBoR2fff1rlUNIvVfGRox4uZtGfRZ5H3wP8KAsxlPibn+RxiOnInYGACJWaNSQkpzq
	I
X-Google-Smtp-Source: AGHT+IG4mIMgMfm7UJJHdm53OlTrf/WL+dVBu9a8HvRYr0qY3FpmqwdTD5bFPK8tyQL7rw8v7fGJBg==
X-Received: by 2002:a5d:4851:0:b0:34a:3148:47f2 with SMTP id n17-20020a5d4851000000b0034a314847f2mr8427060wrs.18.1713882756058;
        Tue, 23 Apr 2024 07:32:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d5646000000b0034b19cb1531sm5103831wrw.59.2024.04.23.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:32:35 -0700 (PDT)
Date: Tue, 23 Apr 2024 17:32:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: robh@kernel.org
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: qcom_hidma: simplify DT resource parsing
Message-ID: <71169d0e-e751-4c08-b6ce-36c37f63879c@moroto.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rob Herring,

Commit 37fa4905d22a ("dmaengine: qcom_hidma: simplify DT resource
parsing") from Jan 4, 2018 (linux-next), leads to the following
Smatch static checker warning:

	drivers/dma/qcom/hidma_mgmt.c:408 hidma_mgmt_of_populate_channels()
	warn: both zero and negative are errors 'ret'

drivers/dma/qcom/hidma_mgmt.c
    348 static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
    349 {
    350         struct platform_device *pdev_parent = of_find_device_by_node(np);
    351         struct platform_device_info pdevinfo;
    352         struct device_node *child;
    353         struct resource *res;
    354         int ret = 0;
    355 
    356         /* allocate a resource array */
    357         res = kcalloc(3, sizeof(*res), GFP_KERNEL);
    358         if (!res)
    359                 return -ENOMEM;
    360 
    361         for_each_available_child_of_node(np, child) {
    362                 struct platform_device *new_pdev;
    363 
    364                 ret = of_address_to_resource(child, 0, &res[0]);
    365                 if (!ret)
    366                         goto out;

This if statement seems reversed.  It will exit with success on the
first iteration through the loop.

    367 
    368                 ret = of_address_to_resource(child, 1, &res[1]);
    369                 if (!ret)
    370                         goto out;

Same.

    371 
    372                 ret = of_irq_to_resource(child, 0, &res[2]);
    373                 if (ret <= 0)
    374                         goto out;

This is actually what triggers the warning.  of_irq_to_resource()
returns a mix of negative error codes and zero on failure and positive
values on success.

    375 
    376                 memset(&pdevinfo, 0, sizeof(pdevinfo));
    377                 pdevinfo.fwnode = &child->fwnode;
    378                 pdevinfo.parent = pdev_parent ? &pdev_parent->dev : NULL;
    379                 pdevinfo.name = child->name;
    380                 pdevinfo.id = object_counter++;
    381                 pdevinfo.res = res;
    382                 pdevinfo.num_res = 3;
    383                 pdevinfo.data = NULL;
    384                 pdevinfo.size_data = 0;
    385                 pdevinfo.dma_mask = DMA_BIT_MASK(64);
    386                 new_pdev = platform_device_register_full(&pdevinfo);
    387                 if (IS_ERR(new_pdev)) {
    388                         ret = PTR_ERR(new_pdev);
    389                         goto out;
    390                 }
    391                 new_pdev->dev.of_node = child;
    392                 of_dma_configure(&new_pdev->dev, child, true);
    393                 /*
    394                  * It is assumed that calling of_msi_configure is safe on
    395                  * platforms with or without MSI support.
    396                  */
    397                 of_msi_configure(&new_pdev->dev, child);
    398         }
    399 
    400         kfree(res);
    401 
    402         return ret;

This should just be "return 0;" otherwise it's returning the positive
result from of_irq_to_resource().

    403 
    404 out:
    405         of_node_put(child);
    406         kfree(res);
    407 
--> 408         return ret;
    409 }

regards,
dan carpenter

