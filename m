Return-Path: <dmaengine+bounces-5337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7BDAD4D81
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175E13A5441
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCC5236430;
	Wed, 11 Jun 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSd9C5zM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9829D19;
	Wed, 11 Jun 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628474; cv=none; b=DwizaBuRcXyx2NNWnWA0kSSrA8dpoP0U8WH+pz2yrCOZ1gLYtyTs5uAJR+MwFz72ecFGxhgpc8eSlL8zrjmf/hiEwLHr+mgOSjIIezvIFzl/VdqtqqVX0ZGfIw4RP3QLbUghC8EfESdS9X84aOu6LW0pHMLkvJyWw6jztPS6tG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628474; c=relaxed/simple;
	bh=bCVbSVwSBYwY1otSjwDqL5GnRL1mK5EbHr8LxlhsFIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdflYyRC+vdBPJfmemo3CkIhkUymucavPxST/H2MW+GVqHhPyQmFtB1Rm7ZLqQYPkM2oDyAm4gdX7fB45Ma8S4k2hKhI0Xr9kfo9V2LAxG/PmCLBtES3gO9Srm4wVATd3nclIgCORNlUYpg4Scd5TPb1lukt7yLHSaghqpECRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSd9C5zM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c922169051so359339385a.0;
        Wed, 11 Jun 2025 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628471; x=1750233271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFY1n8hKD7YHLP1kf7MxSpa9O55c6JB9hP3AwHqMzNA=;
        b=aSd9C5zMK1tAxoVRawCXkvQpBqgp2CoUCcmUERqQ7WZtltUI9H8EYddyeWi9WGKIvL
         SPgx21DrhMhXe9TPE43b1jQhBjQWw+TicUYq3ezWU7xGzNmhlxN4IPy1MqZM3+hmKIHg
         OdbHXjGvxQcUR30+KYYjKbY6sGIRPRoHxh6zR4CLtPEU2qScqwj3e8Msui2zLtMCa0LC
         L6EA36zx3mwoKWGl7MjPgC3Hc8to+0y9vXrpy4tfE4gda6961VRdwTE9k7IwYhkfd79m
         75kjW8fI1UEaArdfuPJml5iM5uZTlvNiIefHmdPxzD26J6kbJ8P43DqWFtWlzhg0ZX3C
         tcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628471; x=1750233271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFY1n8hKD7YHLP1kf7MxSpa9O55c6JB9hP3AwHqMzNA=;
        b=YRRvaeMNEXOZLz649WLUpyP+0wQhOG8mCH/XZutjKwo/AS1eU/TzNAYtNO3KtgCCOj
         wC5JhQRcSfKrMzChN/E7Hn3MKBF4fo9Z8FU4pkGqxULk5QyweFreOhSIDLBshCrSdO6Q
         YZayAa/W4I3Q3m+FstlwOFly/4Ca+DJxqBuOmnjpXsNNAMBGmIcGkYIlwDkqr7OcbVlp
         cjaxrd8vfV5KtbF8uCAD8f1/e5On6wOuMNU68h30yxxxvFNDauzalTGa/vcfL8jXtsfp
         yDEnWmO2nIjHxPKsATGVMRHcG7MURPDzDMzkks5vs32JLkAda49jzu+74ge1JExsyw2C
         du0w==
X-Forwarded-Encrypted: i=1; AJvYcCV/BciA+dt/ufrs5PgiMBPidLAt9g58rVZs1XMGg6BZ1coTOvgiIvL/sPn93TyBCGORKwi3ildH+KEWsGhp@vger.kernel.org, AJvYcCVH9EhMK9cN9WuE1k2Fful0XbA+viRE9c/06YgMsaPNLoypO3+IkqyfqQqoQg50+WBNO7PLGYRD+aXQ@vger.kernel.org, AJvYcCXa9fD9/j4Wh+QHFNEO4KVKcWRhLx1IIJqmnIAE30pSiTQOJ3r4vg2zSpeNA9dBQnxxoRJseGGwRyBZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxXk4M7716T02ZNQ67wpx3XB2ptjmNgsH78Ec3byeDmZ7asmwJQ
	MsC37uXUWo7l1Mk5IPlW5FiyxTwnDZyAipMwDT4C6bx5/zpdOUh64GVS
X-Gm-Gg: ASbGncsLrjc22QTx8SiwYrSNaObz8apXHdGHfzASJIF148S8cu4z6Wd3/FjXmosvPcz
	zfjw1x0kFXLk/PA4Rc9UMgbwiq/tBtcZNhO+9y50lfmZnyB9ebQlaT6XM89DtZV9Y8hHsJwlRUh
	PbDcBAwkPjfWEUDLk2suw5bzMe5IerfSPJZ1CsYkaYqed9ZDfywAAlf4chxErBJC9MKOqffIDt1
	+/CHy/7k5kxe3eHVPMp6RpXJ32Xp7tuNZCefJfF6HfJ1LTHO8UwDfRfVL52SemCf5cV0nnVM3GQ
	C9jImDt7K4VHAOiyjisStbaKW5sIST1cc0l+3Q==
X-Google-Smtp-Source: AGHT+IHiEq5NOVnzdI0MVOEGferuZ6sPEJIWdas7r5sxvl6GtQWSqqWA/YtBhGlgc6evDKBd2SnF9Q==
X-Received: by 2002:a05:620a:29c9:b0:7d3:9ecc:1bd2 with SMTP id af79cd13be357-7d3a8805fe9mr315815185a.10.1749628471424;
        Wed, 11 Jun 2025 00:54:31 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a609092sm825539885a.65.2025.06.11.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 00:54:31 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dmaengine@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/4] riscv: sophgo: cv18xx: Add reset generator support
Date: Wed, 11 Jun 2025 15:53:14 +0800
Message-ID: <20250611075321.1160973-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like SG2042, CV1800 Series SoCs also have simple bit reset generator.
Add necessary code and bindings for it.

Changes from v2:
1. patch 3: fix wrong reset ID.

Changes from v1:
1. rebase to v6.16-rc1
2. patch 1: apply Rob's tag
3. patch 3: fix wrong reset ID

Inochi Amaoto (4):
  dt-bindings: reset: sophgo: Add CV1800B support
  reset: simple: add support for Sophgo CV1800B
  riscv: dts: sophgo: add reset generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add reset configuration for Sophgo CV1800 series
    SoC

 .../bindings/reset/sophgo,sg2042-reset.yaml   |  1 +
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        | 25 +++++
 arch/riscv/boot/dts/sophgo/cv18xx-reset.h     | 98 +++++++++++++++++++
 drivers/reset/reset-simple.c                  |  2 +
 4 files changed, 126 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-reset.h

--
2.49.0


