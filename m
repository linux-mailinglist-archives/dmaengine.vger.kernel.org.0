Return-Path: <dmaengine+bounces-5341-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D0AD4DAA
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA6C7A24A3
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFF248F7E;
	Wed, 11 Jun 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF3340iL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4C248F60;
	Wed, 11 Jun 2025 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628489; cv=none; b=allfd6xcH6wyTthR/sbvpyrc40OMF5XF8GMJsoiNFWadbb7oAU+MJwaQ38zR6wwaN6NlazMT/VITaSZfa2G/Z7WI3cXJ0HiwhXVVq1uPjb3LP3T4MEPQkckl+5f54r3MoUpjsgu7oWhEgKhdNLLBRL0JRYiU1n1I13EtL1tPNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628489; c=relaxed/simple;
	bh=6W7L6mLae0Gwk7i/q8VTDrfQXggHDNqoAV/kISEHYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSamdQjgqlsDKy3s44Ii2jx1aIniSAhEdv1Tv6DxfOfUpPmIsS7LVVltULMgBO016JFCYQOB+YAfa9wYd/FQomlX6kvApk5QyypBnb6/NCjRrK+UxG4aA/CK5KoaIJPVlEZPr53Y7odzoHdD078sma30SFQeMiBMOD1BnWvkq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF3340iL; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-735a9e65471so3838761a34.1;
        Wed, 11 Jun 2025 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628487; x=1750233287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnz/0tuwhYz4DMu7YFaY4+MBrOn4ASwg3VdpZXlOjs0=;
        b=ZF3340iLobIaiQQMLYfpKc5fbLjnW+1dxbS/6c0aOIfcAqi6s5gPydB5dVtbAyFGCK
         0CYp6jONcHpqxwTzbUXBtb1ivRL3U98b+wCaOQevu5lFEaInNevBfsKcejNrscSd16+L
         abs/IxMxvQrcHcUIJBu+dSdup8vp8mL38s5xQ+8db5nQMe+BcKiluOYCZs14Jou+op+k
         WM0a6dFGK2IAlqJ2a5HE+kOyUFDs2+xyecdPi5DmAd4+bzf7YoX99XtfhE+fA20sNtN8
         vi7Ta1eYbo2JnLj2SdZjlAVbWndkfFQrsluWBj6+SOSStv7yZ0UJQ5VmO13dNcpPkDuR
         5n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628487; x=1750233287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnz/0tuwhYz4DMu7YFaY4+MBrOn4ASwg3VdpZXlOjs0=;
        b=LqbcGVPu9tRKZDhFh9su1ZOrYv0B4HYOlaTY9zohtk4sJ84ma1O62N4/wiU/+jKuYH
         Xw1NvTUkR+k0Td5nylLbnGuEqcXetiJBWVmlLDZgUqyr+1XEoEbPZjOo/cgPJytBMb8K
         xEl6Cfa+QtsXqqMVjBvbj2cd+d6IpHed6Tw3q/w1ORMV2xgpwMLLTMQXI3g0fDxXFh+S
         ARkXIWHFMh972/9egZT3uYhovKJoDAr4tAPfdkgdrZA6KKJdnarOQgStzNDcCuZ/4d7U
         qpcBQYog60JmzoKBrsmhIxaKKSZpk1+Zv/6mGeRPN9/rgn8v2vrLts5O7fPQW+KFA7IE
         U0wA==
X-Forwarded-Encrypted: i=1; AJvYcCU65kTtKafD13e4Da2vdK6yHYPaYtMn6UodQTJAtSXkWACoEWMWzQB6CFrWhOrmGfNoO2kl7KznIoNO@vger.kernel.org, AJvYcCU6Sougu2tZXGvlUCwDOZuYIdZuzXu5LLw4yaHiOP/vxE+s/DyybbIyMkggnujZzHjWzHx3aLte5kZvwh9i@vger.kernel.org, AJvYcCW2gp/xkGBzE72NaSX4VxsmrSQYob2GN6aULZCpS+xdukZlmMjiFJk/wRepr+TbM8GO5DmrwxEsMN54@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CRoZ5TuxdU0BXSLlRXlnvamcRBSTDfTRPuB1nt9S79P06tBg
	OHKtGR75TgX4QmBJKblFswDP9h6Rd6iIamo/eeaubN8DjmWISYNikZ5OkQpvjsmp
X-Gm-Gg: ASbGnctUMOk/lOGoeafGMXXHssXPzc2U+/zfeUsK/3ceS/PQjKZ/4+0piAmoVNxZYk0
	NWRaKWcGB2bny4jtsWd85ICcusiohhx6FOpQC4KTjYihXSVCaGmSLXOz2QEk5zd18cHBycGNEDB
	3OrABmNlgvQM5LTCdil1h7keIBmHX6rAuI7siS5n5h404Tn4npxn8goE1/FC16reXKMnxpa9W3m
	uUuC4Gegdvlvrkkp3lWKelnOf8QikL/wZyJ30bBgPih8d7crIBZJmWwpmieNzBpZq3tjRfgLkso
	0pSmbEHQEiYkNDLc4ojaZjrZ3AgXkeoWM5dBCrFZ9RHUs8kT
X-Google-Smtp-Source: AGHT+IHeItzokrKWw9l9oyv6bnHcsz0dOO4Q14MZQ9wo4Ra1X7rEUiC3C9xPLLzARwfKUZ6RpDZSIw==
X-Received: by 2002:a05:620a:288d:b0:7c5:af73:4f72 with SMTP id af79cd13be357-7d3a89330ebmr320142685a.42.1749628475059;
        Wed, 11 Jun 2025 00:54:35 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b1d1d0sm79736646d6.77.2025.06.11.00.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 00:54:34 -0700 (PDT)
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
Subject: [PATCH v3 1/4] dt-bindings: reset: sophgo: Add CV1800B support
Date: Wed, 11 Jun 2025 15:53:15 +0800
Message-ID: <20250611075321.1160973-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075321.1160973-1-inochiama@gmail.com>
References: <20250611075321.1160973-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the reset generator on the SOPHGO CV1800B
RISC-V SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
index 1d1b84575960..bd8dfa998939 100644
--- a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
@@ -17,6 +17,7 @@ properties:
               - sophgo,sg2044-reset
           - const: sophgo,sg2042-reset
       - const: sophgo,sg2042-reset
+      - const: sophgo,cv1800b-reset
 
   reg:
     maxItems: 1
-- 
2.49.0


