Return-Path: <dmaengine+bounces-5294-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5363ACADC8
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 14:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2722F7AA82D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD661FF7D7;
	Mon,  2 Jun 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hoverinc-aero.20230601.gappssmtp.com header.i=@hoverinc-aero.20230601.gappssmtp.com header.b="0r17womi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0E1C84B1
	for <dmaengine@vger.kernel.org>; Mon,  2 Jun 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866015; cv=none; b=ukSNzZXT8Y6OtCoYeiUqwrw20tLIpNz50QW8aBqysmZz1Nq0sE5UgBpqFgmJhQUlj/xfMrQmszgDg8F0c4ms+hqAgya6B3d7IOlQPlI2m16rSazz+w0b7Y80GNIprDY50kGFETIYrvvGiF2rdWlyDTJ0kzN3cU2LbDrtT9gsBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866015; c=relaxed/simple;
	bh=TZQnFEZUatAq88keadkzQVQ19mXfbFxCyoSuzojUJKc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ENanwfb0ZyW4/Smagl9qXIHI50nR5l4ekUoBvOz9WZmpiab4KipitQXxdZrw5lSB5cNMPTmgvyB3a5NwMCkGFY3DIus7hTCsLG7FjZXB9zKqxlFlHT5hfAq0eW7z/H+hHz+/JUTln5/KsunW6+lG284b76UwOuL+PgZZVnavQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hoverinc.aero; spf=fail smtp.mailfrom=hoverinc.aero; dkim=pass (2048-bit key) header.d=hoverinc-aero.20230601.gappssmtp.com header.i=@hoverinc-aero.20230601.gappssmtp.com header.b=0r17womi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hoverinc.aero
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hoverinc.aero
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adb2e9fd208so685324466b.3
        for <dmaengine@vger.kernel.org>; Mon, 02 Jun 2025 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hoverinc-aero.20230601.gappssmtp.com; s=20230601; t=1748866010; x=1749470810; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CByIEmwNbreAD0XgC5ZcEii5+BDeozb6OBY1ok/uGHk=;
        b=0r17womi/b2ibocLxXj8knLTh/5pilsEmpjxURcI4SqcAqAKbDssLtgG3dAD67oJEQ
         +8d1IVSTZzJyt4p+ONb4cWn3QAlAQLpARwIq+95E6GArUlTA784/stiKX+G/inYpRhjI
         JxKveLOuObHEOTS0ybjvjxp2ZPgVjpAKB0ihFtr7YqvuRccdF/3/5wUiDYABw1QcOx7G
         O4pMhaJ+eWzK/6qNEy0Eo9+XJV8dlOX5zbIB80QfoEviIqmfLaa4IHuzsQgtfJjwHhpy
         XYE2PhwDs7LRBGjN+GGTnoSLCt8qvUaMccRhHe0HyDfBgOG0jnHXhLcbWG6bpQ4gvJ0h
         bixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748866010; x=1749470810;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CByIEmwNbreAD0XgC5ZcEii5+BDeozb6OBY1ok/uGHk=;
        b=KBo9oy13s4k/OFj3aiyl1E7gE94rF/oZaVVCREThyRNjRaMlF/qPtI5RPLC7x3roqP
         yW6aYANXfp7BSEgBmjQIN8RSz+OXFUgJNEnY4XOst55ys4l+Y/xycBzjsPNcETIOwjrZ
         mUoiCHK+ni+N8KBZR+Uj/jjnS29JC40e9cTbnBgoJ2q/ndFPONTaOSOuaorhkxKCQc2h
         telf0mBmRptO88kFrps74VZvmjvE39cOQE9/p/k0zLv/lok3CMPY5dv10lccEA4ibocG
         s8Fdos0OrHTgNd1P38fzHlUVou1sWYNDMx/AZXgR4OhmDzVhejoHn20LE9Lz8P7XJe2R
         YJ2w==
X-Gm-Message-State: AOJu0YzaSGeGA7ZrFWsJd5uEyNVUgqB8QkhFgUHnLSBw4r6iJUKwgSEZ
	kr+ew8g/IV0ION1iuSrnA0dPTjdkfSKmZe6ptnfC4Qu0eHEtIY1XnJsZu1h484gch0UEBLQM0qx
	QYSpYg0lsSzQvRyXXFFsXTNN+7gpvLSdRtlWFj9pT/mFXJalg9DUNKZw=
X-Gm-Gg: ASbGncuylQcY6VIoDwrAhwXVmLIxCPkbp2loXWK+d5ap5LOMt6WSXnE5iQMCXS/VIBj
	xs2/pmZczNF4tYnNdtiN7Gh2zyWAmyIPrKoPtqWTvQIr8r/8OtekCWPcNudqjUqP81sp0xLurHX
	NhlZd7Aa4oueojInnA2yleE3FFe9Cnzj17ww==
X-Google-Smtp-Source: AGHT+IErGFzFDOUeX2f7MF+OdFYI9kvw9rqo+qLwQtmCzPEpsGtUVvHyaPI46yz3Tw2wugY6u4zF6IS2GMyjgc+csL0=
X-Received: by 2002:a17:906:3ca2:b0:adb:41b1:feca with SMTP id
 a640c23a62f3a-adb41b2359emr551845966b.61.1748866010076; Mon, 02 Jun 2025
 05:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Harris <kai.harris@hoverinc.aero>
Date: Mon, 2 Jun 2025 13:06:39 +0100
X-Gm-Features: AX0GCFup2q8FQGMK49YGdkVPhliyC93HL2eaQkMsM7JAtntOKDeISX22uCxUyXM
Message-ID: <CAEKq62St_j8g2bpUaC+1NZBJuiZ7+sqyRWST8KPQsDdCu=VhNQ@mail.gmail.com>
Subject: Running testdma.c with altera-msgdma.c
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am having trouble getting testdma.c to work correctly with my
hardware design. The dma block itself is in stream-to-memory-mapped
mode, and the driver I have hooked up it is altera-msgdma.c. via the
following device tree element:

```
msgdma_streaming_read: msgdma@22000040 {
  compatible = "altr,socfpga-msgdma";
  reg = <0x0 0x22000040 0x0 0x00000020>,
<0x0 0x22000060 0x0 0x00000010>;
  reg-names = "csr", "desc";
  interrupts = <0 19 4>;
  interrupt-parent = <&intc>;
};
```

The design is verified via u-boot, so I am sure it is an issue with my
understanding of the linux dma flow.

I am using the following linux-socfpga kernel: 6.1.68-248715-g4225a1924e16-dirty

After building and inserting the above .c kernel modules, I configure
and run the test:

```
echo 8 > /sys/module/dmatest/parameters/test_buf_size
echo 3 > /sys/module/dmatest/parameters/iterations
echo 'Y' > /sys/module/dmatest/parameters/verbose
echo 5000 > /sys/module/dmatest/parameters/timeout
echo 1 > /sys/module/dmatest/parameters/threads_per_chan
echo 'Y' > /sys/module/dmatest/parameters/run
```
And then am seeing the following kernel messages:

```
root@localhost:~# dmesg | tail -9
[ 2563.232872] altera-msgdma 22000040.msgdma: optional resource resp not defined
[ 2563.233436] altera-msgdma 22000040.msgdma: Altera mSGDMA driver probe success
[ 2583.491836] dmatest: No channels configured, continue with any
[ 2583.492473] dmatest: Added 1 threads using dma0chan0
[ 2583.492479] dmatest: Started 1 threads using dma0chan0
[ 2588.643726] dmatest: dma0chan0-copy0: result #1: 'test timed out'
with src_off=0x0 dst_off=0x0 len=0x4 (0)
[ 2593.763748] dmatest: dma0chan0-copy0: result #2: 'test timed out'
with src_off=0x0 dst_off=0x4 len=0x4 (0)
[ 2598.883724] dmatest: dma0chan0-copy0: result #3: 'test timed out'
with src_off=0x0 dst_off=0x0 len=0x4 (0)
[ 2598.883771] dmatest: dma0chan0-copy0: summary 3 tests, 3 failures
0.19 iops 0 KB/s (0)
```

Any pointers would be much appreciated!

Kind regards,
Kai

