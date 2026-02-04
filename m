Return-Path: <dmaengine+bounces-8731-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPIGH2pug2kFmwMAu9opvQ
	(envelope-from <dmaengine+bounces-8731-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 17:06:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DFE9DD5
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDE6300462C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7B352937;
	Wed,  4 Feb 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLOKz3gP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890B2D5C91;
	Wed,  4 Feb 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219245; cv=none; b=E1lBcur4fzanWt/C1retqlbqW53KNSTFvacGu0YgNbHXgSeiS4KHwxBYILWYXgGmksWrT7rY0R92vKrjOHz6vYRAX1R4HlWExlRR6qdw9hsh6TFdl000oZgm6zu4RRHV8kSKKHVylmaFts0nyhRdOxzLNySyNenW/769P4NOeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219245; c=relaxed/simple;
	bh=GFVl/OdIldkXuI4DxqliO/JdZ1WGAbvqpjMviEkKHPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlBkZ/9acsBuNKv4G8NEGtKQYBubTHymCd7jpzickdG8nVhd9isVxNG6VnvuQ9SroBpJNgxIG/30w6RlRGR/qtLxLJI+iqiLqXYcrd8eWUbgGxuGOZlU0EeNJQeIz8yjuSjHsmT3aoZrBs+0ykEQCL9u5xx2FE86Qs6huVR8eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLOKz3gP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219246; x=1801755246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFVl/OdIldkXuI4DxqliO/JdZ1WGAbvqpjMviEkKHPM=;
  b=FLOKz3gPML/mJSkOFTgbBNWKjT+ZAp0WbI9zcz3wHqiGhrHo4Y1p6AWW
   AcCHKpHxZOgc73Kz9pqZE2pIDh2Zmvi9XiZrev2+s0taaRfsqhVO1cZcI
   292qkfrVVOhthYS6Q4ducqse102DDVE4LiHpydWjVzMsFOYAyJfkuv1DE
   dkUcnAxnq7Xe6GySBpHixll4LjT6vgFSeMeqDJbUy1slUci1MSIgpXA2h
   G0kBrCfA335Wfa7HvdHZ5hZhaSc2QU5dGm4hTLvbWZPUz8MWFu7abqCho
   TbWInBvpsnGKqLIbcg++H4T9viJiEF4ew52PIWxD+pgnUDviZzuClnPii
   g==;
X-CSE-ConnectionGUID: Rmjq2EMLSXax2536leeVew==
X-CSE-MsgGUID: Q3B9GjibSP+8kNsQnuwi3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71573281"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71573281"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:34:06 -0800
X-CSE-ConnectionGUID: AsnpLe/bTtyw1Owchlr60Q==
X-CSE-MsgGUID: inGNAAsmTvqp3pwGrQ+gHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210232121"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 04 Feb 2026 07:34:03 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AE6D695; Wed, 04 Feb 2026 16:34:02 +0100 (CET)
Date: Wed, 4 Feb 2026 16:34:02 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260204153402.GR2275908@black.igk.intel.com>
References: <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
 <20260202102225.GB2275908@black.igk.intel.com>
 <5ed857f5-59ae-4052-8f2e-dac7fcd014cc@app.fastmail.com>
 <20260203100452.GE2275908@black.igk.intel.com>
 <5d134f4f-f7f4-4972-9adb-6d10ede5c1bb@app.fastmail.com>
 <20260204123107.GN2275908@black.igk.intel.com>
 <5ed53c66-69e9-45e1-9b89-e3d555ff412c@app.fastmail.com>
 <aYNHeqYYa9ixrksM@smile.fi.intel.com>
 <e7a0d992-ed5c-4435-b567-e0b873360a48@app.fastmail.com>
 <72c71247-8b54-4820-b25d-34f659e7f957@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72c71247-8b54-4820-b25d-34f659e7f957@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8731-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE2DFE9DD5
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:12:57AM -0500, correctmost wrote:
> > I will try to debug the config issue and retest the touchpad with the 
> > proper config changes.
> 
> After fixing the config issue, I now see "Dynamic Preempt: voluntary" in
> the dmesg output.  I also see "# CONFIG_HID_BPF is not set" in
> /proc/config.gz.
> 
> The "probe with driver hid-generic failed with error -22" message is
> still present and the touchpad doesn't work (full log attached).

Thanks!

I don't see any other way than adding even more debug. It really should at
least be able to parse the report descriptor as that's exactly the same as
in working case but let's try to figure why it fails. Can you add again on
top of everything this one:

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..0a6e373bf899 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1282,6 +1282,8 @@ int hid_open_report(struct hid_device *device)
 		return -ENODEV;
 	size = device->bpf_rsize;
 
+	hid_info(device, "open_report, start %p, size %d\n", start, size);
+
 	if (device->driver->report_fixup) {
 		/*
 		 * device->driver->report_fixup() needs to work
@@ -1304,6 +1306,8 @@ int hid_open_report(struct hid_device *device)
 		kfree(buf);
 		if (start == NULL)
 			return -ENOMEM;
+
+		hid_info(device, "open_report fixup, start %p, size %d\n", start, size);
 	}
 
 	device->rdesc = start;
@@ -1333,6 +1337,8 @@ int hid_open_report(struct hid_device *device)
 	while ((next = fetch_item(start, end, &item)) != NULL) {
 		start = next;
 
+		hid_info(device, "parsing, start %p", start);
+
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
 			hid_err(device, "unexpected long global item\n");
 			goto err;
@@ -2736,6 +2742,8 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 	const struct hid_device_id *id;
 	int ret;
 
+	hid_info(hdev, "probe starts\n");
+
 	if (!hdev->bpf_rsize) {
 		/* we keep a reference to the currently scanned report descriptor */
 		const __u8  *original_rdesc = hdev->bpf_rdesc;
@@ -2753,6 +2761,8 @@ static int __hid_device_probe(struct hid_device *hdev, struct hid_driver *hdrv)
 		hdev->bpf_rdesc = call_hid_bpf_rdesc_fixup(hdev, hdev->dev_rdesc,
 							   &hdev->bpf_rsize);
 
+		hid_info(hdev, "new rdesc %p size %d", hdev->bpf_rdesc, hdev->bpf_rsize);
+
 		/* the report descriptor changed, we need to re-scan it */
 		if (original_rdesc != hdev->bpf_rdesc) {
 			hdev->group = 0;
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index c2de916747de..63ea9c0c6ce1 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -63,6 +63,8 @@ static int hid_generic_probe(struct hid_device *hdev,
 
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
+	hid_info(hdev, "generic probe\n");
+
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 5a183af3d5c6..99a12ef970bd 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -800,6 +800,8 @@ static int i2c_hid_parse(struct hid_device *hid)
 	if (ret)
 		dbg_hid("parsing report descriptor failed\n");
 
+	i2c_hid_dbg(ihid, "Report Descriptor %p, size %d\n", rdesc, rsize);
+
 out:
 	if (!use_override)
 		kfree(rdesc);

