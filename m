Return-Path: <dmaengine+bounces-11834-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IKlnBckwQmoZ1gkAu9opvQ
	(envelope-from <dmaengine+bounces-11834-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:46:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579D6D7A16
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=FjumGrU9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11834-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11834-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C46D302E910
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF53F86F7;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470D3F86E1;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722723; cv=none; b=lsLKjYymyYfHG61k3iyS0YtTPXDttcExjxVhKpkjC04amm9KjPhAVlhNkQKGMIqL6cYnTkTAf6yRz+PIB3C/sa9na36su1l+AfBKuba832YvkOwXfLCRQ2ejB15tLsUP+prdC3L3cCnwNMFqpvaNO0wHXcu20jMQ0wWFmx/ZeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722723; c=relaxed/simple;
	bh=EEIPKjIO+KkdnYvxCNUbUzbpbcAL4I2ToYQqaXxdMzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZHBgdtuS1ENub/Xc4U1tJ+UQURE1w640hnXdhD1A9eEpy9//EOn5dmpfKVcL7hCeRrHkcOrU/kmHrHSCVHVpMcxOXDk7WYXUH8pD4zLB4LUKC0Yn0lJwGDEd4+W/7JxLbgG07WNf3VIR14HeG83OyGtyZ6tAKZ+pLW9+vu3kYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjumGrU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B1A2C19425;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782722723;
	bh=EEIPKjIO+KkdnYvxCNUbUzbpbcAL4I2ToYQqaXxdMzs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FjumGrU9TJmwvxxsnA7DYsZEKjkS7xSNAwaBQwGaX/KuBzTh8Fh5+W814GyoImFDs
	 f+7gIXg2udpxNQarETLERNlyhOqMsT2id1CBkM4RX605igzkt9C2Uor2wbvYEPmClp
	 pSy6tvEKkjZCclNO+vc+A7RErl+FH28ZuJpq0y6+cXAHvgZhI/XH848cMIGdhHkBlB
	 E9OyTFz8qq90Pa6QU6xWrpLCcydUBwXrX+Zu0chhjoLMw8KZwx1H8s8PbTb5B3RGdr
	 GjlM/UtU0q6e/vvSSYA+74LTn8PqrCHob/gwzOAcdHucUEAbW8eU9GhXk4nHaOJn5I
	 wyhm25uHd/MEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F55C43458;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/3] bus: mhi: ep: Implement flush_async() callback to
 flush async read/write
Date: Mon, 29 Jun 2026 10:45:14 +0200
Message-Id: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJswQmoC/yXMyw5AMBBA0V+RWZukmnj+ilgUQ0e80kEk4t8Vy
 7O49wIhxyRQBBc4Olh4mT2iMIDGmrkn5NYbtNKJSnSKk2WkFbtxF4t1rGKl0ygzeQs+WR11fH6
 7svotez1Qs70PuO8HKQlnIXAAAAA=
X-Change-ID: 20260627-mhi-ep-flush-b50502718a9d
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=EEIPKjIO+KkdnYvxCNUbUzbpbcAL4I2ToYQqaXxdMzs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqQjCfKvW6Psv5ZdbX6f8IN9tWLJiESISCNI8EO
 nZipYdAgRSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCakIwnwAKCRBVnxHm/pHO
 9c5TCACcWlPnEt0ry/oWcQcwS+qFP62S5Mi6pD4dZnXLl9IYtjq8BKAdA62o+iXBJ/CGnrKy4Mk
 K/sW0rELwp/WzvR5eOnWu4AhAS1vbmz2CSUNF2kZYtAIAbS9RUuT2+5VxmGj/GUbJRZCE9+Z2qY
 9HznTaila5F4c8DXd48m/b5dZiVm2Fmgd1D52lpuNKCi/0f1dN6QCRkM+irUEJLzKEb9mELKJ3f
 BlO0aeDK2ITO52VPLjVF6tVZRWABJh8glV+4ID+mNDc/yYmxIAzs8rpv+fEoPuhbj6W+iaO0z3H
 4I5G6rIXMN3VWx8Ys5VqgKJ1uhsWQcsAWogALjBKTer636K5
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11834-lists,dmaengine=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:stable+noautosel@kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,noautosel];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,oss.qualcomm.com:replyto,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6579D6D7A16

Hi,

This series introduces a new mhi_cntrl->flush_async() callback to flush the
async read/write operations performed by the MHI controller using offload
mechanisms such as DMA.

The MHI EPF driver implements this callback by flushing the DMA wq. With this
series, the MHI EP stack can guarnatee that the channel specific xfer_cb() won't
be run after calling mhi_ep_remove().

Merge Strategy
==============

The dmaengine driver change can go separately as there is no build dependency.
But both MHI and PCI EP changes should go together. I'm planning to take both
MHI and PCI EP patches through MHI tree.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (3):
      dmaengine: dw-edma: Implement device_synchronize() callback
      bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write
      PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read/write

 drivers/bus/mhi/ep/main.c                    |  7 +++++++
 drivers/dma/dw-edma/dw-edma-core.c           | 16 ++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 10 ++++++++++
 include/linux/mhi_ep.h                       |  2 ++
 4 files changed, 35 insertions(+)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260627-mhi-ep-flush-b50502718a9d

Best regards,
--  
மணிவண்ணன் சதாசிவம்



