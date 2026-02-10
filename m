Return-Path: <dmaengine+bounces-8872-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JKDCoYji2lyQQAAu9opvQ
	(envelope-from <dmaengine+bounces-8872-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 13:24:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA111ABD9
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C280300BBA1
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D2C327C0C;
	Tue, 10 Feb 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3SXTl8W"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16932E8B94;
	Tue, 10 Feb 2026 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726276; cv=none; b=ZAzuMo9YqNqk/V1EBd6aN1CUC5Yb7jOMKBw5uFEBCVlpAb77UdJaCNCkCoKtyPeCOOVIS75Clb1/l85bfHXXUVtfkUdc7CsySujI6bpUZG0rfI7RI3zo8G2nCFI3Y0WUsGpTx/XZ3h+fisL50duJ1KtJDlaJqTtbVH4FqRET1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726276; c=relaxed/simple;
	bh=FLQWelYjH6J1n+nBExy9QSwJEf2Zi8oQm4rmyPVVcOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqqxRFFK6qgyb7fQncVQ6iIbW/jujmHqpU5OoBKcxeZ+8iw56SsytKOfFP9N5D6htSpkDl8I6rZQ3naOtr0ipvDCu5K7vUd6sM1mELtA2GceUGpTVpX5TCzL+7X1Y0LjbbK6lcJNs3d8wPFKTCOWL5JJ5NVISSiXIyetHB2fEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3SXTl8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0488EC116C6;
	Tue, 10 Feb 2026 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770726275;
	bh=FLQWelYjH6J1n+nBExy9QSwJEf2Zi8oQm4rmyPVVcOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3SXTl8WawiMrGnByBlZdG7fqTMzmtHd4U30kqoanm19yddGD7yXphRq74NITWtXd
	 LkpCWVZLgZrSiKdU1w11mte+U/yw/AYCbFva5fRbgZI8iocHtCTYlJ3POacYMU3J7y
	 +4gS6UnDToI1fV+BIKSoCWaY7/zsqqnF7wyTzq1kfU2C0ttqO8ZaleaV2AzZZgw24M
	 v3O9ObfiO+GMSir+j/T4yOPDzn3O3qNRnERN3KpYpkRQrH93JGVnHI+iqrbFtd3FyD
	 wOvyd/TV1iFo//sNyPHgwKP7TykxZdKXtxSpQKVhPk6G/6uftYxvMzmQSJKcwTvxSn
	 5aPAV1KyK9G9A==
Date: Tue, 10 Feb 2026 13:24:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aYsjfTtA0EsXwh69@ryzen>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8872-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9CA111ABD9
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:08PM +0900, Koichiro Den wrote:
> Tested on
> =========
> 
> I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
> R-Car Spider boards:
> 
>   $ ./pci_endpoint_test -t DOORBELL_TEST
>   TAP version 13
>   1..1
>   # Starting 1 tests from 1 test cases.
>   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
>   #            OK  pcie_ep_doorbell.DOORBELL_TEST
>   ok 1 pcie_ep_doorbell.DOORBELL_TEST
>   # PASSED: 1 / 1 tests passed.
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> with the following message observed on the EP side:
> 
>   [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> 
> (Note: for the test to pass on R-Car Spider, one of the following was required:
>  - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
>  - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)

I applied this series on top of branch pci/controller/dwc
on Rock 5B (pcie-dw-rockchip.c).

On EP side:
[   39.218533] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
[   39.219125] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback

On RC side:
#  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
[   40.297892] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
# pci_endpoint_test.c:279:DOORBELL_TEST:Expected 0 (0) == ret (-22)
# pci_endpoint_test.c:279:DOORBELL_TEST:Test failed for Doorbell

# DOORBELL_TEST: Test failed
#          FAIL  pcie_ep_doorbell.DOORBELL_TEST
not ok 23 pcie_ep_doorbell.DOORBELL_TEST

Any suggestions?

(All BARs in pcie-dw-rockchip.c is marked as BAR_RESIZABLE.)


Kind regards,
Niklas

