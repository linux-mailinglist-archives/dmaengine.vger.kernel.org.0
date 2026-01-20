Return-Path: <dmaengine+bounces-8394-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN4bMa/Db2lsMQAAu9opvQ
	(envelope-from <dmaengine+bounces-8394-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 19:04:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB6490C4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 19:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9F1E6A75C7
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3F427A09;
	Tue, 20 Jan 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3jWciWk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B34F4266A1
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913559; cv=none; b=ALytUGKrsiOe1ILXajurqgWmIfj8Fv7UliH8rCi2oqSFHybrSemRmuxlSgMkFeoggW/zM2i8l3nvzwCPPD2LaVzf3VWIOQeMBhEXksnbWvUwgL4FCWeR8TzPTXZmbvxFN7Q14L47xo3dYTdHuOzzwfOM1GtoMozSMlLToQauSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913559; c=relaxed/simple;
	bh=dLT4BztcJUHlJv2mbKW05XmD97+BUruAVhf1PrnKC0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5zDwx0ZJNlUa2PGP6Ol2x/KWBK9MPZuZsLg/XzDewLjZWFNRapB7uSUQ7gB09PBZec5rFMTQa42WY9Z77L/LcXK0T6GHQwkB50+TuSGqKv4mcQoF2DzGRbUAKclQgn21BqYxHbwO5tIZ7qnwbj+6y2r5jyOfk6nzxbuZ0v84NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3jWciWk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8768225837so758161266b.2
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 04:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913556; x=1769518356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ttQo/ynjtoD9vPtncN+5aFty4ApifbhAAoI8HwtRUw=;
        b=c3jWciWkuZUsvfBQhPCwCkmAwn4UcWt4E0D9OSmWVlN6M/tyYN3Jw8yoe/CZQJc4W6
         4CnmXCrhl2RhzXfsK8mQ1zI4eV1j0KnJh9ZxLYstNe2cHIKDVBQb+sCOQB7aKuxQZl+s
         /kaD36AxieB5fVBP6RlAzaB4rx7oGu8YOUFM9j5WuUb37jSqYxFq+qSFfQY5oSuQvMPO
         oCTDGsA3zeciiKOT9IXpFACDJLWgLwiTXt7fZsuMlqg+uxU25VFztDPGaxrcpEoXOz2p
         8jwomSStQerQ1CSLunDVgX4hwT7IQ7imHz72vjlxF84U2jDKC7YYZOBJC9hFzEwDfsar
         +fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913556; x=1769518356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ttQo/ynjtoD9vPtncN+5aFty4ApifbhAAoI8HwtRUw=;
        b=t1/nSsx5D2hIWmu85RoNOVglzM0XVCGWo4TUZ7euZFFbhZMhyMSikZQm3Wrza7DTX5
         X2T6lfmKMri3QaZelyWsiZE79yGom4bhBzfYhxC0N6Px3LWOClvgqrDDhHHbV6zgSi51
         k1BKCi28/6jAE6lfTU6DqTu82PmtwYBE1cLTxiJVpic+BRpfiUjbAgAw5f7G41Sprc+b
         lyLtPnrYhhA0cbMcgki2UEWebib2QWwvANwCd+l7mJw/ZTgm5nMeINLTR//QUIZTBTo8
         F1EcCjY9BtxRU08ci1Bim8q5zrAWQJLO6byskybpfGHoFKxcHcXcEMc1mY3AcMI46584
         hWJA==
X-Forwarded-Encrypted: i=1; AJvYcCXRnB3f6R7OrKySskFLUFRAzzvByBxzF2Ysix3B7oVPENb8oXjDDz3nQBQgTwmHQLnaoIVGh5Cl5EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRmY2olJ49jxurmmbTjvbLdTYdtzG/JSTSxr+VJ8mMc5JH3VV
	pzrAhUR4gK6cTMWxL97oVIAhygH3EmQZdqx7bB/6mMh/VjtU0SRlv2l4
X-Gm-Gg: AY/fxX7XSgyzGfzwIbnPyyOR8gZa6xCSY1WFzcKfYKmBdz4oJNKuRlpXGowDjvYMA68
	Dhcu01/FqsdLJj/CWY9OXrUZayFwlywgrjdgRfOQkZXZl+4b2OJ5VbRJEIO8vLwt0mhzy9pBcm0
	mSekyRfvIcURfs0P0IMe8Kcs7HuR5yFcyPTY4lZgavd/diqw0qj+AArDpAu/CuA4ZVBYOK30zHT
	ZVh8HM8fqRJ7DIF892MeTxv5R5Fxogb/GmO5pQcb0MeD5NZMfI9dm+Grt8gB3blvCTkqJ6fW4lZ
	KFl1LHoOPL/iEF9Rt4FtmNjtK5w4RuvFz5FUptOOD3iuJIg/W9pnkjgPIx6ooArzYA/tLmyCbYH
	tQWx7t/wXJWdZ0oYEBKv+66nHAr2vbE4FRe+t8rXgD9X/BnywmMyC69VYMat8J4KiiwGVclXDNn
	abTplDx02M8/LWqmeqhT6OUgTCEkVp3cu/1cNGuC2wwUyMhg==
X-Received: by 2002:a17:906:209c:b0:b87:d255:39ff with SMTP id a640c23a62f3a-b87d2553c76mr452807266b.32.1768913555294;
        Tue, 20 Jan 2026 04:52:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:c8c7:2ef6:8ac5:5556])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959ca32esm1420626066b.41.2026.01.20.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:52:35 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 00/12] Add support for Renesas RZ/G3L SoC and SMARC-EVK platform
Date: Tue, 20 Jan 2026 12:52:11 +0000
Message-ID: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-8394-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,baylibre.com,glider.be,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 71FB6490C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi all,

This patch series adds initial support for the Renesas RZ/G3L SoC and
RZ/G3L SMARC EVK platform. The RZ/G3L device is a general-purpose
microprocessor with a quad-core CA-55, single core CM-33, Mali-G31
3-D Graphics and other peripherals.

Support for the below list of blocks is added in the SoC DTSI (r9a08g046.dtsi):

 - EXT CLK
 - 4X CA55
 - SCIF
 - CPG
 - GIC
 - ARMv8 Timer

This series also adds SCIF support for the RZ/G3L SMARC EVK board (r9a08g046l68-smarc.dts).
 
Test logs:
/ #uname -r
6.19.0-rc6-next-20260119-g31b78275d04b
/ # cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:        262        109        324         98    GICv3  27 Level     arch_timer
 14:          0          0          0          0    GICv3 185 Edge      error
 15:          0          0          0          0    GICv3 186 Edge      11820000.dma-controller:0
 16:          0          0          0          0    GICv3 187 Edge      11820000.dma-controller:1
 17:          0          0          0          0    GICv3 188 Edge      11820000.dma-controller:2
 18:          0          0          0          0    GICv3 189 Edge      11820000.dma-controller:3
 19:          0          0          0          0    GICv3 190 Edge      11820000.dma-controller:4
 20:          0          0          0          0    GICv3 191 Edge      11820000.dma-controller:5
 21:          0          0          0          0    GICv3 192 Edge      11820000.dma-controller:6
 22:          0          0          0          0    GICv3 193 Edge      11820000.dma-controller:7
 23:          0          0          0          0    GICv3 194 Edge      11820000.dma-controller:8
 24:          0          0          0          0    GICv3 195 Edge      11820000.dma-controller:9
 25:          0          0          0          0    GICv3 196 Edge      11820000.dma-controller:10
 26:          0          0          0          0    GICv3 197 Edge      11820000.dma-controller:11
 27:          0          0          0          0    GICv3 198 Edge      11820000.dma-controller:12
 28:          0          0          0          0    GICv3 199 Edge      11820000.dma-controller:13
 29:          0          0          0          0    GICv3 200 Edge      11820000.dma-controller:14
 30:          0          0          0          0    GICv3 201 Edge      11820000.dma-controller:15
 31:          0          0          0          0    GICv3 418 Level     100ac000.serial:rx err
 32:          4          0          0          0    GICv3 420 Level     100ac000.serial:rx full
 33:        206          0          0          0    GICv3 421 Level     100ac000.serial:tx empty
 34:          0          0          0          0    GICv3 419 Level     100ac000.serial:break
 35:         13          0          0          0    GICv3 422 Level     100ac000.serial:rx ready
IPI0:        23         26         19         22       Rescheduling interrupts
IPI1:       237        385        152         90       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop NMIs
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU backtrace interrupts
IPI7:         0          0          0          0       KGDB roundup interrupts
/ # cat /proc/meminfo
MemTotal:        1887948 kB
MemFree:         1849056 kB
MemAvailable:    1816424 kB

/ # cat /sys/devices/soc0/family
RZ/G3L
/ # cat /sys/devices/soc0/machine
Renesas SMARC EVK version 2 based on r9a08g046l48
/ # cat /sys/devices/soc0/soc_id
r9a08g046
/ # cat /sys/devices/soc0/revision
0


Biju Das (12):
  dt-bindings: serial: renesas,scif: Document RZ/G3L SoC
  dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
  dt-bindings: soc: renesas: Document Renesas RZ/G3L SoC variants
  dt-bindings: soc: renesas: Document RZ/G3L SMARC SoM and Carrier-II
    EVK
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
  soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
  dt-bindings: clock: Document RZ/G3L SoC
  clk: renesas: Add support for RZ/G3L SoC
  arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
  arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
  arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
  arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK
    board

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   1 +
 .../bindings/dma/renesas,rz-dmac.yaml         |   1 +
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../soc/renesas/renesas,rzg2l-sysc.yaml       |   1 +
 .../bindings/soc/renesas/renesas.yaml         |  13 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 219 +++++++++++
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  41 +++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   6 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 -
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  22 ++
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a08g046-cpg.c           | 137 +++++++
 drivers/clk/renesas/rzg2l-cpg.c               |   6 +
 drivers/clk/renesas/rzg2l-cpg.h               |   1 +
 drivers/soc/renesas/Kconfig                   |  12 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/r9a08g046-sysc.c          |  91 +++++
 drivers/soc/renesas/rz-sysc.c                 |   3 +
 drivers/soc/renesas/rz-sysc.h                 |   1 +
 include/dt-bindings/clock/r9a08g046-cpg.h     | 339 ++++++++++++++++++
 23 files changed, 918 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
 create mode 100644 drivers/clk/renesas/r9a08g046-cpg.c
 create mode 100644 drivers/soc/renesas/r9a08g046-sysc.c
 create mode 100644 include/dt-bindings/clock/r9a08g046-cpg.h

-- 
2.43.0


