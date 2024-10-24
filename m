Return-Path: <dmaengine+bounces-3524-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2239AF127
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4181C2270A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB5217913;
	Thu, 24 Oct 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVm+lAtu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FA2170B4;
	Thu, 24 Oct 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796884; cv=none; b=QBWPYVvUN62xIr42T5bqRCJJTJWEUaRb6tpIEsKH3CRG8GH3dvga2oLhpJwdtkuXELKc78bqgAKye5cqwwb2xwnStFiZ/RTpd2ZFrOQefQKNkhSf3tEZ6RyjHjnjHTlKL6pnt7Gks99siBWWbzabq4L7h2zL2+6JDkjnFFp3ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796884; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P548xQJ4sdSLp0avfEphcSCxe0rzKqLSYUGvJGckRlYznFzJSgfF6/fwAAitiAKutZzF6E7chj5wCyeUEZQWVU8aLbc0FWmtz4oJKWHBAcacODZqC5B7bzJyGxuJvTRxokKNwZmCI6aLTejNtt8P+AO8Mx0lKr6UMCPotw8Y8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVm+lAtu; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so1883287e87.1;
        Thu, 24 Oct 2024 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796880; x=1730401680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=FVm+lAtukzBCYJNer/wdyyQKAyAH0Y+UaYgxLM1ih09fzB+9K8ldxAFcSgmtpC8u5T
         U+t1QEnQ0pw/yzATWplzXc0Guo+jDWh3IR0i46D/mftIunN5avdqo9B/Q7smidmL+TTH
         QA7FepIDfDRw+HZkLploEspadqYFBqcErJuQLQCKawZiPZVrSKyp32eRNon5VniuxGwH
         NG5CKnei3ryg+LWsQLZnpWGbhaOadTitmHN1DhxqDbGt7iR2ffItbaSSwCNX814M7nBS
         BGsOZIPP6jcQ+dXaHgFXz/uucb/zKtwUjnwgKJAjWpz6Vg6lC9xDsqP9BcK8z+ZiCb6W
         uP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796880; x=1730401680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Y8iDVozhp6hqZvxdSe1CV5nA7pQIXzdemJD0iSYJy2zEHOcKB1VVPEJbyTqvNKRrcL
         m/pzp/lMW2j9bBrVsMyIeqasjxwmaWlMo7hDFGZOhy4/OHP/0Qh26TyfBLCAdds5BhRK
         WKsGt4sTXlp/mZNDrxUOcz7n1fRatTYM75J0lh728jWm/+8fGzCEf3O5m2FjLelVHPDI
         ay2XrFtxtWiyEurcj8BcQFFk5kiH4F7mxJOHYj/vqMIAMRzewr/Agb19vjEh3Vtwy49Z
         VXnUFsi6Of232KkW2HS4NW26DGkGc2K6hQyV3CneBBHdSYUQ7NNMCKT/nvdoCId7gRS4
         4Ytw==
X-Forwarded-Encrypted: i=1; AJvYcCUBHxT/zLTKprZu9LqaxRfcRBBF8rz1mkB8PcucLUgIHaky0XUdwWMM9eF5Yx28n0XfuHopBr2CTGVYdWc=@vger.kernel.org, AJvYcCUJ86mnMUmYP0tM7D1bwNF2N+Rm2bAqNTFFxcEO3ym2BK8v8IQ5VzPbyMP5Iqd0I3IFVWx+vUf7UMrsaQ==@vger.kernel.org, AJvYcCVAeBoPIBfrho4xutB0IhI9SAgaFswGrrgKO9FcP7JyEfskjJ5qF5KDvqIFuwHYn7vNA8cu0cAqakvo@vger.kernel.org, AJvYcCVYzABuZ5o9fara1fzRXwbSXIZPh5mCgjLecY1loJG7Dre5BjzvubOmK9X6NIa8//YTxBvbwxO7EqU9SeM=@vger.kernel.org, AJvYcCWFcX3dFCWMIkaJSX28CHnzbT0u7e9q0ieKacM1JR7F9JvZCFecCCft5COmR+/yjZ0+fgP0nBNROMVf@vger.kernel.org, AJvYcCWI1L5ukvth4tbdEndZGKQBnJaLSj2LBgx+1Bkp9HBOTIQgxAfWE+kSlsZujsUeASLu8YKsPCzky2t9YA==@vger.kernel.org, AJvYcCXMidXNHPmyJoPYPO2xdmmbtLsZfEqdlI7O739BqAwYDSIoqdIEs8oBjUBVt94M3WrIZT0ACSN+XcB9Yg==@vger.kernel.org, AJvYcCXN898ilBlYPLmY/e7SpEoTuhYn8SCD0GkdEHkIqJabF5e/0Qy0arCSFzkne21/M7gdl2TGFlLb7tBY5k8=@vger.kernel.org, AJvYcCXh3/oBuRxfZY/fY/l1TAeDdvb9o28aXpdsrFOlLWBfZy/vDwGNbU3yOSaYZ74D2sPaxCaulZ+o@vger.kernel.org, AJvYcCXiFHjN0zw/eLpIexySyBkiMsAX
 N+YXEC5RDaZ1K3tEwfsd1euGX4fNiw7c/c+ZUAjK9Ur277uWxQ8=@vger.kernel.org, AJvYcCXiMcBf/F/EQzmqQrghxsVYnGRu1mYUUq/dsV4gEhUC8mBGX+WdjZUM6b666/LemKg+zA1z6IrRlIOX33vfrxY/Coc=@vger.kernel.org, AJvYcCXtVeeRghFvbozNW73pCgY9ohAJ5X+rWtExvcO8RFfJlCOU3HrIFikRCiyMVCDSXYJmtR3wqNlB/QYn@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTAGtIPQYIQ4Sy39v3xaHKBkQNhmTzLf4xW7seq81KW2w1ILq
	9qqbWtNeX+G7wzypfamr11/1URUf6jw2vdPA+8zov9kssjpbWJCP
X-Google-Smtp-Source: AGHT+IETTuttvRfcjHFxUxlBXUh8zWcfasdjYDGAua3Nkw5drKhC93ffF2cuCm55+Z4PoQPBga4KhA==
X-Received: by 2002:a05:6512:1150:b0:539:e8c6:7c1c with SMTP id 2adb3069b0e04-53b23df6302mr2158154e87.20.1729796879880;
        Thu, 24 Oct 2024 12:07:59 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ecb4sm1452266e87.247.2024.10.24.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:58 -0700 (PDT)
From: Russian Troll Factory No3009113635287891861913185655201581154924871136012270414348130192884625096102051382618699963388092363229814700261331871761329474 <vladimirputin693389@gmail.com>
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru
Subject: Magisk patch for android nox devices
Date: Thu, 24 Oct 2024 22:07:54 +0300
Message-ID: <20241024190754.14508-1-vladimirputin693389@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi, the linux mailing list.
You have asked me for your opinion. I present my opinion to you:
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK




