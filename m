Return-Path: <dmaengine+bounces-8462-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNpEKHRRc2kDuwAAu9opvQ
	(envelope-from <dmaengine+bounces-8462-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 11:46:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D2F74894
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 11:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07662312245D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D037472E;
	Fri, 23 Jan 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K88/W9CP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3B36B065;
	Fri, 23 Jan 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164920; cv=none; b=IOi4WulMeOYjTz6lD8QE6PzZU/VgXkQgHWXZTgMFV4Me5YoiWz30WxZZgbmXK0IhyVo8g53u/LLS4jDy21w4MBWlUF+Ezb+P0XpXyOxIpBNW6uJ5NddIVroobGX4cTL5maUUavz9xnXT/q05vwNZNN4yNo9oRa5Ud7hvAcKPfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164920; c=relaxed/simple;
	bh=HLrViGVqTC3/G0gsvexqTtXtxspwQxSEDDyxgTv7J0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBj0Sxg/0rRPFPncLgDap7TI/zrUmiH2mcGRR1z9wMjciZ1o8+cW44UfV8qs9w/mxQC+Td2XKNlW5d7U2ooiEscWe5kbbKKWdHGHGdZbL7rprDErrfyHA2cdQ8AYU1OoX49Ed2lwohlXscx39nBScZu9FVh0nWBLwy7QjXG4q48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K88/W9CP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD424C4CEF1;
	Fri, 23 Jan 2026 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769164920;
	bh=HLrViGVqTC3/G0gsvexqTtXtxspwQxSEDDyxgTv7J0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K88/W9CP38VNlsvsGY4cizpdtUmca1k9hFtwHK6PhgaPrnWH2CuKqJNx2ce/1927M
	 z23lyd1zE8UmSTz14bfD0pUa+rz3qzLSS3Gejq+50Di+KpU/4d5+UwtA2hPwwcKCQw
	 kfIBJcXPFtTQrxF11z1ZKTAgs+14yWjmqzr6G8gaUCSb7GY8R+LvDYI/JTEXRpG4xY
	 T563JVc+Z6dfwEZml6RKjN6FWTXb0TDprK6z1oRVCxsnbpX7vAUDYAHQCWqGTqzWW/
	 dIY1/0GXJC4d0etgGilNFSXTaohdoNdfOvXOnorf7evKJdma7+vkcUuZfBooAn9fJp
	 yREIVdvmIZieg==
Date: Fri, 23 Jan 2026 11:41:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH RFT 4/5] dmaengine: dw-edma: Dynamitc append new request
 during dmaengine running
Message-ID: <aXNQcowVEMaE1xr5@ryzen>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8462-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 03D2F74894
X-Rspamd-Action: no action

On Fri, Jan 09, 2026 at 03:13:28PM -0500, Frank Li wrote:
> This use PCS-CCS-CB-TCB Producer-Consumer Synchronization module, which
> support append new DMA request during dmaengine runnings.
> 
> Append new request during dmaengine runnings.
> 
> But look like hardware have bug, which missed doorbell when engine is
> running. So add workaround to push doorbelll again when found engine stop.
> 
> Get more than 10% performance gain.
> 
> The before
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> 
> After
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Hello Frank,

First of all, I hope that your:
[PATCH v3 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
series will make it to the upcoming 6.20/7.0 merge window.


This RFT series however breaks pci-epf-test:

Before:
#  RUN           pci_ep_data_transfer.dma.READ_TEST ...
#            OK  pci_ep_data_transfer.dma.READ_TEST
ok 14 pci_ep_data_transfer.dma.READ_TEST
#  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
#            OK  pci_ep_data_transfer.dma.WRITE_TEST
ok 15 pci_ep_data_transfer.dma.WRITE_TEST

After:
#  RUN           pci_ep_data_transfer.dma.READ_TEST ...
# READ_TEST: Test terminated by timeout
#          FAIL  pci_ep_data_transfer.dma.READ_TEST
not ok 14 pci_ep_data_transfer.dma.READ_TEST
#  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
# WRITE_TEST: Test terminated by timeout
#          FAIL  pci_ep_data_transfer.dma.WRITE_TEST
not ok 15 pci_ep_data_transfer.dma.WRITE_TEST


After a bisect, first bad commit:
commit 352fd8d5ed468ea616eb4974b5ac19203528b207
Author: Frank Li <Frank.Li@nxp.com>
Date:   Fri Jan 9 15:13:28 2026 -0500

    dmaengine: dw-edma: Dynamitc append new request during dmaengine running



Kind regards,
Niklas

