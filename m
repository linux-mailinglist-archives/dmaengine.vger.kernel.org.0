Return-Path: <dmaengine+bounces-3521-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3849AF101
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67D01F222EB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888B219CA1;
	Thu, 24 Oct 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejB11U8F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C1218D9D;
	Thu, 24 Oct 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796871; cv=none; b=FAcqYVv9PW4sQY2t/aVNwSGjebBmMD8RWi5QSfXKJQF87D6cgpMIOxjKQRSn5J1ClVwwrDfEWqrjhG/113/YSbr1zRZjfos9X+O7dohTtXEMU1Zse9hvWSj30NtlpRc6iW0MPeQ7ZxL2bDqtujnrCTe1110nN4m7lPQNm4WqIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796871; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPunaxfYVhB26iI3jUBjtp12XnIehqmIbZtHShcGjepy6oJ/F8qwO6qEfnwnFzsuyW760bSDB2Q1vL+jqL2lCBf2dxOHbAvm2tn88qqoU82QQSdF74si9HkvXweYWueA5chhBSjVRCdjSkGARM6VYMUfk1/qnpXAbSGIx2b/0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejB11U8F; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2fb5111747cso13296361fa.2;
        Thu, 24 Oct 2024 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796867; x=1730401667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=ejB11U8FoRG7og3m8Xg6CrrgxoZ2O3O7ChuG8lmUMIEdnVBcs97TLJbqzqzIIJspL1
         0sRXCZ0NmGH2u+rsY2EM1+/TY2RnaYHGQ0oUbjGemw1Oc+61KQJ4GF9IlEMjOMmPF0Kv
         EjhfOs+ja8df/GbNN90upazbc2vPLq/hx1RYyX5fi/4VXfd1V4lznlxl8kDYtz5SpDt6
         aZdjAwXyxiAVsOTIOCJiCnjLwEXqO5xRup4+NnkhqaOmty/PyQraNK4A7iLQJav1GzVk
         wJU/c5zRDBHVzshm7AiBlsZPx5jsAp5qfHO5BT74jkbQZ3H5Z5k5mq7sHOp3jGifou4z
         sFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796867; x=1730401667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=LYMqN/nQM/K63QgeO2QJda3ttkE+AHNjZQd8tX/EsNe/bHqVRVM9P8b8GPrbk5y+Y2
         1iKFbRHOkPKZbRoZxTQe9+NJmQSE878Yhytj+CydVBQnOXuS/3D8gVufLPY5KZSOfLt7
         8flPV4hyUm+yBBs3gV4ahIIaSXOJXMSZa5IjeS5QpOB4bGe+vJWcX2Gxq0gS6ae/iU0r
         DXxiFp6AH3Y3lJ9sqdyeBIiC9QAHO/+OBDxAR3RnoJdfI95glf2sEH+HnrJKSjHS/dVn
         pJfH/Q/vk8A4H8ZYpiZrY3XgzG/wBOUYOOvHBDCY0AFPquSIz5BgcxgvZdku9jnVfWeE
         gBfA==
X-Forwarded-Encrypted: i=1; AJvYcCUEFx5tSphDItcL7yeDnShBQYGoAcDU820Ytx93uiC4s0A45wMU812l/OWXLWMem3+UhOJapU5WNLlu@vger.kernel.org, AJvYcCUUIAox2Tr/fKTzkw7zWvbSaNKNDIQRFR3jUsEu1fpCP+8v+kfmVG1S+uCwP002nyeMyQlpXjb1ccKQew==@vger.kernel.org, AJvYcCVFX8MXhtMNVEopRzx96kEv/rufBWDSGs08rzAd0Ht/yzOMai21jP7InahTv1wFGbuoNuR6dWBGbcNyrHw=@vger.kernel.org, AJvYcCVW1zrniUgrc5hgUTDQtrhAJifsVHAu9NXJxF5ZXU8fDm4a//TTeoRE8pMidzjn5csdlwtaEUJahWq0OAw=@vger.kernel.org, AJvYcCVooQFu9pzQWcqZC31n5TyBApuZ/SXJbFWn7Ll0t6ErZjoeflFbKduDpCF1pgZu2iG27xqdjxvAsMSUZ+M=@vger.kernel.org, AJvYcCW9X9FZyBhrrPyyXq8UWVIpenUlvEupmEBW0Pc4WrcLYM8NN4baqDlN/qOK9BATungILIyRBkZ4e8sV@vger.kernel.org, AJvYcCWD+iunQf6pwfJ4eU2CKecnWkFLLnO7hsecRXsb0HWfNCiRWdL1OzBTadVuJjR+ttULgu7cn3GjUtURjg==@vger.kernel.org, AJvYcCWkZYls7ChPiBl21dvSovQwsbB2YBHtaTNQIlwRfnrPtSAaNbvEyPDI/IvlgRn/ti/++QT5luYGbG/bng==@vger.kernel.org, AJvYcCX7EVw857r7RL6Z0qQaF6+QJ3PFZ2Ww1W/jg99NXPjKOQhlikIWzq5CHHXkTROpUHVxYxsI25/yR+yb@vger.kernel.org, AJvYcCXHpeb67Mx4Kz6epCacKg0+
 kLQLo+LDONUWqntVYd20RolQ0xf9dBXi/KLLXZUo6+DLz/gm2IjD@vger.kernel.org, AJvYcCXIgPTv2Q3fD4r/de8hMhs8YS19nQMzR72dZIyWRhV5EeTxubgw58sDJfV12U8tB2qZKMM79OVrb300AqZT8eIN/To=@vger.kernel.org, AJvYcCXYa56wKRdsqIIFFuTG0ClIDb5wJC8v5KiuVbwbQi7+8BPkBIzxrtP45bvXhpBfIO+0+K4uacvVmBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfhb2OCQHECt/X5LL/7jXnTRQN1xdh53oUdLftrFLX6Ig0VTk
	p+FW14fT7kzsIMjnJuSboWlNjapBGs6ei7Re5rT3ZCQEvzrffo6a
X-Google-Smtp-Source: AGHT+IElo394hROgOjhr+uO7jz5KQypYlu169s1Z7oDtK4DtNcNmW2eaNhmy4alVpru4emSW4ntbNA==
X-Received: by 2002:a2e:be23:0:b0:2fb:6229:c597 with SMTP id 38308e7fff4ca-2fc9d32e620mr48842561fa.4.1729796867285;
        Thu, 24 Oct 2024 12:07:47 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae24b8dsm14823221fa.125.2024.10.24.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:46 -0700 (PDT)
From: Russian Troll Factory No229072043219446111872669757514602190831514292781279135132810425289178499138369441911020342259711302012736581010934125359460 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:42 +0300
Message-ID: <20241024190742.14475-1-vladimirputin693389@gmail.com>
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




