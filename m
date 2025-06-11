Return-Path: <dmaengine+bounces-5342-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ECDAD4E01
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7A13A330A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5549235355;
	Wed, 11 Jun 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/mRgMjx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7712CD8B;
	Wed, 11 Jun 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629472; cv=none; b=YBXmu/I9FnVtjVONtA1tu2/oZvnkBQ+2HI9z6hD6ZtmlA0eCOREEkDuoAbG+eiXXAJZ4qUSTDjJPLlkYKExqJcq2c/+/W7iDzSEka4vRupYT9E4o8ChC3cZl7tMYAmWl2Rf88cyfWDdOELLViclUXOvDfqaF2J85RLamkUJx+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629472; c=relaxed/simple;
	bh=kTkKSzhE3N+5xcKYpvA81X8dq2z+SsYne1oPzkYDPYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7rXMMXW/UPHhfoyPoi1ZBZJ7jHdcOAkrpBrTas8ze0rffjWOA8BwQoxaPqmwSQqGUWBrQcDLOO6sJvITQ7eUMCffeDDFlbqbTWiiz/kP7M4gsb3bjC1vfuZb7YJOFlwYTUD3b3jxtBWr+NbDtF6BUzZ+l6nj0HsPAvB1BglcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/mRgMjx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a4bb155edeso78642721cf.2;
        Wed, 11 Jun 2025 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629470; x=1750234270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZZMQxOY3jdiUUlcRVmJEoq9jtCkBekBHkitKdRBzHk=;
        b=f/mRgMjxXJXGU0fuUIHr+uiBE/h5oajUhTpxdALYhuVvN0A211gKduIa6w8QygutI+
         mNRz/8aBhKu9N4/TnXfiG1/HHw3mMO15Gpyz16iqp+X6Ce9vVATl38pWlBcXE+LEcVUr
         WST9rrY0YY5zaNJmjuRyKVqKkMKlBfjXtBgvSA5Y+stuYvpZ+SnvKYLCvtzqpvfs4fqn
         V+qezkSo1hwu+5hjwCCkzerpSJABYcnbXXnH28BbgdY2+DH5HL9XRpk/tx1llb0LHc8O
         lXWJuheMtWL7aSOxmXS3MtktC6Md9Jh2JhwE1okt8hSB02nyB0lXd7Hhvrp76gV3NVbj
         1x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629470; x=1750234270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZZMQxOY3jdiUUlcRVmJEoq9jtCkBekBHkitKdRBzHk=;
        b=qg4alkjX89iddAGZQw6W1cjrqDM/RJ1RIfU34xBecplDiEG4VR3emL+FEPOHEDVrHk
         DN0aL2xh2NSddvUY0kReJEUvZ0LpATvwgEarYN3rCOeszrnM+NWQFi+w7fff0ebW/Nsv
         xID95RTY9FfoUW7BU+7kwm+Kf2jchBTUuQnp9rqgV+38mko5ZPqBvuwM31DpJlJqYY9H
         ur87XyGrQnogMEb9+zF3wflVUJyZtozrHxayEjVK1KMzEfCV2QzfQJqMuzy7snNkefvf
         nj8+rknCkzRuJm1SItxy3r4HVb5Urt0QSxqY8QuSVhh6VvNl6NljQoxEQ7/mlZtFPxpH
         etrA==
X-Forwarded-Encrypted: i=1; AJvYcCXaOskUD3hNpG9WsVbQka7KjoHv9f0wgcVCuH2+HHniBYCvXGDhVdPSo8FS9F9xtmiqLbApeckU23HY@vger.kernel.org, AJvYcCXku4MJI5gn0J9fCelsH/54ElaCnmsMBQcgQBnkCrsAAeW6D6pWCJI+9/8ygiRZBwfjVrGnUHGQJMxSyAuf@vger.kernel.org
X-Gm-Message-State: AOJu0YzckKJAntWvi1pM9cDH3lQUCpnHLDKO/4Z/Y80C40XHBLNVs4B4
	sjW+p9LpLbU28yctk6WsEzuaahztXOb3x6g1twCpQZz24vtZ+TDB9SD8
X-Gm-Gg: ASbGnctjHQTHtbmccRZKmA4ebK/XGZ/F6D/6Wf1D1rNeKRnjJ+ymVDPaFZcsg+p9doV
	+8XWhMKGAsoPQx+mYVik7hVjvWYdvYVGcL9vlE9FCMNHhpVHFBRcH0ElD2tyQqthdujVbungble
	S9tU9+yMw/n/AQ8xS71ms0XiHi1BbZWnzmJSsVeGldmUjiN+YTP2Vm+VfU1ElA9l7K9IawC4XTb
	i/Rafdu69261oY0eIzWEApxAEnixaGOx2XUAifg+f+18GWRFfBtvrVXvsIR6nEXAJFILxdMQWHA
	FCaK6jFiXslqfc8PiCaSoayf8o2KKnpedjoyeL2vTQzvqwIq
X-Google-Smtp-Source: AGHT+IGZnue+EG+14/hjDiRd+e4Wrn0+S+QrqOcOTcR+sr6Io4g4wyFZ6oXcvJFQ47foHvKNUa181w==
X-Received: by 2002:a05:622a:1f0c:b0:494:959e:26a3 with SMTP id d75a77b69052e-4a713c41a06mr39119801cf.34.1749629470186;
        Wed, 11 Jun 2025 01:11:10 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a6f5c7a22esm57218951cf.54.2025.06.11.01.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:11:09 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v14 0/2] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Wed, 11 Jun 2025 16:09:57 +0800
Message-ID: <20250611081000.1187374-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

Changed from v13:
1. rebase to v6.16-rc1

Changed from v12:
1. remove syscon header and use local offset instead.
2. add COMPILE_TEST for coverage.

Changed from v11:
1. init all the field of the driver data.

Changed from v10:
1. binding: fixed binding id.

Changed from v9:
1. binding: rename to cv1800b-dmamux.
2. binding: remove the unused formatting.

Changed from v8:
1. change compatible name from cv1800-dmamux to cv1800b-dmamux
2. use guard to simpify spinlock process.

Changed from v7:
1. remove unused variable

Changed from v6:
1. fix copyright time.
2. driver only output mapping info in when debugging.
3. remove dma-master check in the driver init since the binding
always require it.

Changed from v5:
1. remove dead binding header.
2. make "reg" required so the syscon binding can have the same
example node of the dmamux binding.

Changed from v4:
1. remove the syscon binding since it can not be complete (still
lack some subdevices)
2. add reg description for the binding,
3. remove the fixed channel assign for dmamux binding
3. driver adopt to the binding change. Now the driver allocates all the
channel when initing and maps the request chan to the channel dynamicly.

Changed from v3:
1. fix dt-binding address issue.

Changed from v2:
1. add reg property of dmamux node in the binding of patch 2

Changed from v1:
1. fix wrong title of patch 2.

Inochi Amaoto (2):
  dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series
    SoC
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800b-dmamux.yaml   |  51 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800b-dmamux.c                  | 259 ++++++++++++++++++
 4 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
 create mode 100644 drivers/dma/cv1800b-dmamux.c

--
2.49.0


