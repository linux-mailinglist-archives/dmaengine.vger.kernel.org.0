Return-Path: <dmaengine+bounces-10719-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCICL4gSEGryTAYAu9opvQ
	(envelope-from <dmaengine+bounces-10719-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:23:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B65B07CE
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B42830300F9
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7973A782E;
	Fri, 22 May 2026 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="i6qDLOHz"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021089.outbound.protection.outlook.com [52.101.125.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96563A6F0C
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438138; cv=fail; b=OiySYfWYlh1/QWm1dvMb5W2cHcGJlRg9FROXROnN7fsUUkLpIgTXZOOzDEDQSsDFbFMgW9rUzIdxFYAvJVprSZSUPo+nH4grLSBol0rKQYCz4rks5i3lp/2hF3J4Ow2sdzQ0H7zQtpatoQBF7aj+uwspZLzKbt+rYI7sAbZJ420=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438138; c=relaxed/simple;
	bh=lRbeg0WMBJyJd2wG6V1cr4Q9QSBy1l+zeATije2HgTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0aKR9Qz9hawe3vkoA3tVJNRS0s6xXO728CXo9zP3DuQQMICRq1lbXU06ARzVulUEeb2YQHXLIcQTkaV4TioDVhlfwjwbs2+s4m8eT35DoebRDOkK6pHbtbm7tk3NIZgI4o3HTHChLudw/pthzwZIz7mQO+FCvZfTo01hOeceXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=i6qDLOHz reason="signature verification failed"; arc=fail smtp.client-ip=52.101.125.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv0nvv8yeeqyCEGHSpTIfEaSIRd7cMhk+/N7mG1inVWCtEn3UWVKAaNHpvF/FVErYXS0+6wTQcLiRLMASneQ2BOTqa7jMPcPj2UWK56T3xbrdtp8GPj2rax6NiOJSBCCeGNVx19q+D1SnbCvTkVckqnfGGXuvkLjpYbrBP7gYyA/Pue/tPepAx7oLbGgOPRzEWjZUZmfKKfGtMkBz/AHQJ9Os1QWBSQzWCBfh5DT8iFq8joQuXDj7VabPDhCcDiHOsOqa2lATZNTPOGXW0KuP9kun8eYJC8pQEjs0QUJs6k/NeIQs491spm7R2G+TALB4hDf2b0D3QA24fohi6A5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkSGeuRjehz4cppAr6uhod6+Bdxhj2v0KNmCOcR2YSM=;
 b=UBCSlqpIVRDcZs68T6v/C3PAn9HI7t9zxPUx3D82r65jBQM4eWjFUea2YAdqtYxWQ780BlOMjMGm1G2ieB5dKwn4RavVRMCkGp0Se1A6LZdvnUE6CE9ghjwE8YuODZkiGXTbM8g2LvfnBMtQbgq32NDZTPp7KlOTvvucrvCrihKWn9PMtKwsvQNRnRpZqr1YVzUybZCFog104M5ljSjTncsrLBvj2c/5dqrp5G3XplmJzHF3H5NeHUd5GGhqNcqdz9dGCDqwndqPv0OTn4MYRuJEEMT1+zCGj5sVqgIOUFpxUmbmw5i+S5DJzsfKmdYtctZv6lnKGGBVEZzSrN+Lwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkSGeuRjehz4cppAr6uhod6+Bdxhj2v0KNmCOcR2YSM=;
 b=i6qDLOHz5zg9n8Yk4QgG1atpbgmG6JPHLcRAAwKf4v/TdvFEv+MDwAnc9fypATMnpFYenzJkvoO92kXWcR4L39CD+Ad2cnmcR+1CXW8o/RcrHUVMYdbpWlBLAoxNEmRzhy/iJQXkrNp2qk2dh91rHnhwPyM3W9SDF9j4wFpXKOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2540.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:22:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 08:22:13 +0000
Date: Fri, 22 May 2026 17:22:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <ne76elxedfnngi7dilpyvpzwm7tghyj6kpg4ninwxecxsajkkx@zkarppyurl2s>
References: <20260521142153.2957432-5-den@valinux.co.jp>
 <20260521165650.534061F00A3B@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521165650.534061F00A3B@smtp.kernel.org>
X-ClientProxiedBy: TY4PR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:405:372::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2540:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fd0825-d1af-4869-7564-08deb7db39f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|22082099003|18002099003|4143699003|3023799007|56012099003;
X-Microsoft-Antispam-Message-Info:
	E1c8qm38ONKZthWbn+KXs6kTs8nK2+CgbDFmoPX29GWcDM9Z3goTZ1maalhHiRFes3Vv81eFsM9v9GSSP0kefWplWWHVjmKFyTVpbI8jrOC6DG1uxp91IJT1X+CQJ//yUxqUMqTL7QTWp3AziWlKyHtSORiizDxdZ2ySKi5HvVG+ylf4fC9O5o9t2I3mqobCvt/1o4wesOaYKIamDxRw/ka1Z3bTtFWWTKjInpHgasQQWp8zwuvRfSklJur6FExj7uPmXo9t9zz13mtjQWUh1Mxq19J1jlpMsT0bf+JhcRiBC7zCmyc/s6Vp4rKChiuPeQZKnbvFG7CFrLN9Au/vThOQ5lhQxryl14eYd6eZ+Su1SH8LtB/GcJZihFViA3yPPynaLMqNBW66CKIyxVSo3aLb8PukHpxalEdIwmv5GLNU0AtTmU5yF50tUsHciIAuZvRX5S6OY/H6i8McD5vKTfkrDXEuXPKEf6Kjq631JiCiyzKVhm86T8hf9zfRkZ0rL9sB0WUgL1Bku5e3V2vL+dM8ITrgiaI+Iqiwp6Z+A6+rxWk85MbUw7x1u+OkqOuG8oXXiLfXgc+yxE2k7lQwWOh72vloSZTImvfAcK32Zh03TBZWDZp23UykmQG+RJawgmVbWE22rJ7zzrIzQzh5Qg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(4143699003)(3023799007)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?tcrAZ5i7hcTj9mCkFifJ5wkGyZkdkl3x6jue/PWreWQ+hWj3E1vLTkKVGl?=
 =?iso-8859-1?Q?a3VLhsGE7Lpjdwh6AN1x2SnNJTZjgNVhPHNENrqT9oQV5YkOgm1k1ve0kM?=
 =?iso-8859-1?Q?4v91G+W1sQd6zLfTtEpLVX5KH48YW60X7A5tpQN6u1XpiCooQ8vsMxW1ZV?=
 =?iso-8859-1?Q?tmScD7t8xWuIlXl1YsnGDwy6Vv3gBw6q7X3F+edEWFNCbDl2F++mXLLo/F?=
 =?iso-8859-1?Q?Le4oEqUt18ScMWx79e1YAXUR8qJ9itjkj+Or9h7yk1FIpeUuRYdTDerQPV?=
 =?iso-8859-1?Q?pPkW34X7O03MBHGUFXj0yHHKb3oNiYe3oRtNH8zsJ1G/kiCf1cXg+Ew9+g?=
 =?iso-8859-1?Q?rm876/s0RPwlpP9cLLlwrNrNfR8LO69KT2XMWDfOw1ht5QvPyNKOIQYMqp?=
 =?iso-8859-1?Q?85CMOHq+ejUp4Ch9wpsD4B2fiU9C1LR2j0Jm8CzGHV6Ea4MH6INwtyrnOj?=
 =?iso-8859-1?Q?e7xvvSSVZqpJIolYlFYN6y2GIDrJ1vM+L6YS4VMDlVtEPsjzzKwF2BbrVr?=
 =?iso-8859-1?Q?Z8NnQhlqXU2d5Uni/TLFf8XEWR26AHFwfkkclGGAHvJ56XlvN9KXuUpPdf?=
 =?iso-8859-1?Q?Ht8B88iVOjaKXk4B45821jssqRMkVhs+SLyU7VYc3uGjask9KdpmSbCkZy?=
 =?iso-8859-1?Q?y9yCAuVs/yNmN00Kw+F4ayXb0WwiYahYnRMX3sdtkKzgjURB99mjQoLGQM?=
 =?iso-8859-1?Q?pyxBSHrcjOQPW2RrH8QtDoFK4S3iLzvJ3n+sn4fE7POreq7xHg9C1eCwO6?=
 =?iso-8859-1?Q?s/KQXq7Z6uTfNPzTM6Hd+v/XLk2cEkqAgo9ix+5uUwJHuiPWECuIa3y54K?=
 =?iso-8859-1?Q?SnkzLi6oxn0d2eRIe+iQyuks1TlgEOTjPbHpmdyMod2kuOXZxr3bgHiXXT?=
 =?iso-8859-1?Q?kIiVABtaKCX3MCwtyI/jYxo5zMaeYuGclSD5wzTeFW2+rsbKKw2JgKLQRo?=
 =?iso-8859-1?Q?bbjUedtzBGZ86ealMJxfNzqvQDkKyEghOnYwYq4kiJZ064JmMuUsuI8fBK?=
 =?iso-8859-1?Q?wBuykQ6cuYmM0miVhUXRfUPGznh3jRa6OVMnyLV7HCcXvnZDjL1pzVAjNs?=
 =?iso-8859-1?Q?CT/8KurIqDLMKfG50oFOC/ppo08JUajVwJJquO9la7Ms4TXJEY69EMBwxe?=
 =?iso-8859-1?Q?t++erjfLmyIgUcMGmRCVxPX3DINbxy6kdg7eSZKF3wqe3jWa2dH9iZoD20?=
 =?iso-8859-1?Q?ny5JI7pSz1Z5sgQBTiQBJbvCfa5ASKfPduQAqBBV0siBHqO5o80IihZI4K?=
 =?iso-8859-1?Q?vBDd4MGqT13VE0oLUSdTrf+mTjF3N+SDGxd/chPcyR44kAG/BIiMltTOHx?=
 =?iso-8859-1?Q?WgipdjFUb00KzRHsKq8cKiZ6jSi55gpWWLNYSfbZjY4Twny2UZMrOQDlNX?=
 =?iso-8859-1?Q?7yBmLVO/U/igCgRCs6cJ519yJYkSul+i1LUWOWpyEim5u1PdsVz8uc7NBK?=
 =?iso-8859-1?Q?rKRo2e/sjBGgdyssdEACWoGeulEd2rI7DrRF/Ie1QLsLbefCbTN8IMzToo?=
 =?iso-8859-1?Q?tofADmDz1oUFYI2BzCozDHM01YNrrPH64cRAOwKGavmzHR6TM4Ji28/dlJ?=
 =?iso-8859-1?Q?7HjHTP7xEOhpC3gfoKV0cF9vzYxjsUTRGmchS201UALIvcGQl45/caI97I?=
 =?iso-8859-1?Q?wRmAWGa+h+SnjknGWqlsTgtOf6IU36tGNRjIlknhV8YEDZCgJLlPcfi7Ab?=
 =?iso-8859-1?Q?/5gNa6yXYGRfMIpo1V4I9u7gW+lwHWhGElWQxm8gCvYxu0XoXgmWb0p+fS?=
 =?iso-8859-1?Q?u67NGI3Av5PO1q5HP7wacZyj5gT9a4vyEBvVUQyFDD8sQm/bOmodXx9wz2?=
 =?iso-8859-1?Q?pwCy30unkq6DM52vSNNgm7aCX3eKIF6smL66newqLMTuD/ZBH/2D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fd0825-d1af-4869-7564-08deb7db39f3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:22:13.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q331M7HCIgxqChN/qk1HZ9Bf+Dk8uvfl5U+B5wRSu4sfhUIzL/gNNaJ+sjUTwE8VF6WoxqNBs/PnzyZhNR48Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2540
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10719-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,nxp.com:email]
X-Rspamd-Queue-Id: 0F2B65B07CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 04:56:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The teardown sequence in `dw_edma_remove` incorrectly powers off the hardware and frees interrupts before unregistering the DMA device, exposing a race window.

I looked into this a bit. I agree the race described here can happen in the
current code, but I think the problem is broader than the ordering between
free_irq() and dma_async_device_unregister().

While trying to reproduce the window with the following debug delay:

  @@ -1177,6 +1178,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
                  free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
          dw_edma_emul_irq_free(dw);
   
  +       msleep(10000);
  +
          /* Deregister eDMA device */
          dma_async_device_unregister(&dw->dma);
          list_for_each_entry_safe(chan, _chan, &dw->dma.channels,

I hit a more fundamental problem: unsupported in-use unbind can lead to a UAF
and kernel panic. I suspect that the teardown ordering issue Sashiko pointed
out is part of that larger in-use unbind problem.

A better fix may be to support in-use unbind in a similar manner to e.g. commit
bf453a0a18b2 ("dmaengine: ioat: Support in-use unbind"). I'm not sure whether we
want to do that now, so I would like to hear maintainers' thoughts.

If we do, I think the fix should include at least:

  (a). Stop using devm for dma_device backing objects and add a device_release
       callback, so the objects stay alive until the last dmaengine reference
       is dropped.

  (b). Add a removing flag and serialize it with the transfer start path.
       For example, dw_edma_device_issue_pending() should check the flag and call
       dw_edma_start_transfer() under chan->vc.lock, while the remove path
       should set the flag under the same lock at the start of dw_edma_remove().

> --
> 
> commit 3dac310797da8c464a27d4656c26826f3d2a7401
> Author: Frank Li <Frank.Li@nxp.com>
> 
> dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
> 
> This commit adds a spinlock to dw_edma_v0_core_start() to serialize access
> to the shared DONE_INT_MASK and ABORT_INT_MASK registers. This prevents
> race conditions from concurrent updates across multiple channels.
> 
> Link: https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 69e8279adec81..cfdd6463252e6 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> [ ... ]
> > @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  			}
> >  		}
> >  		/* Interrupt unmask - done, abort */
> > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > +
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential race window related to
> how dw_edma_remove() interacts with this code.
> 
> In dw_edma_remove(), the driver teardown sequence calls dw_edma_core_off() to
> disable the engine and mask interrupts, then frees the IRQs, and only
> subsequently calls dma_async_device_unregister().
> 
> Since the DMA device remains registered in the dmaengine framework during this
> window, can concurrent DMA clients still issue new transfers?

Yes, they can in the current code. I think (b) would close that path.

> 
> If a client calls dmaengine_submit() and dma_async_issue_pending(), the
> execution traces down to dw_edma_v0_core_start().
> 
> Could this write to the engine_en register and unmask interrupts here,
> unexpectedly re-enabling the hardware?

Yes. That is the path I think should be blocked by serializing the removing flag
with the transfer start path, by using chan->vc.lock.

> Since the IRQs have already been freed,
> would this result in the transfer completion never being signaled, leading to
> a hung task?

Yes, that looks possible if a transfer is started after IRQs are freed. And I
think (b) would prevent that new-start case. (An already in-flight transfer is a
separate case.)

> 
> Should the teardown sequence call dma_async_device_unregister() first to
> safely quiesce the subsystem and prevent new requests before stopping the
> hardware and freeing IRQs?

I do not think unregister-before-free_irq can be the real fix by itself. It only
narrows the window. It does not protect clients that already hold DMA channels,
and those clients can still reach the driver callbacks after unregister.

If I'm missing something, please let me know.

Best regards,
Koichiro

> 
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> >  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> >  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> >  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > +
> > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260521142153.2957432-1-den@valinux.co.jp?part=4

