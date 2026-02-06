Return-Path: <dmaengine+bounces-8795-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJw4IJIkhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8795-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAF100F62
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860B13009E1A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74F425CFC;
	Fri,  6 Feb 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZY2DxWdz"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FBA3EDABB;
	Fri,  6 Feb 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398822; cv=fail; b=ait8kz7uMszm4RV3EZvuzZosigNU1Q50JgHQXRTJsnmm6rZAuIZGL8TlQNiapgZnna1/OuTH5PnXgXtggx6YEowxE1apzB3BBOJjJ9IOMfwknJecPQP66XHoeMj2A/+qdjxrVz5S/mWcocIiptup4ia+GgCeRNtMLSvFYrpWHhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398822; c=relaxed/simple;
	bh=TN0AdwGEEWwixWT89708Gph5G8Gwql9DcJ+/3hJCs+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+OxcVtxyii2K8wL1UrbO7XPmf+g+yy3LimiT7r0BRQqJjTqTAmS+zxNXBgYeFM2DK5m/Fyg4j9y6+vXI1aPq0IsMgJhkwOH1ICkPygmu8uKL7aJUB+zHmWYkW6EmdsPKztkx7Zw/c4GkzasgJL8t39Mnr7pAZhsYKFWuP49iZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZY2DxWdz; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsFESVpJ4b9jgpqdlhIYJBKj629ZGEN8sMdpo64Yxo/uLYayK9q5ICBI4bzBgTIihX+Vaz2Zvsl7r50AA918hYkf8LEn7i4iSpePJNP96wFD4dMIFz4I/cFUWH1dAo4es0kJzsLKVH/I9PBJf5dGwvrYHbsV5GofKYWCQtovzq+erZ7OyKs3H+mOtwmJCHZzBBLAWujcqVTVoWGBfykHKVntZA9ha+C4a2MJLv9ZIJes0lOrPZxTNokzSQxlmzXN83UVTft3BuguGbaemyxOSXb4t8s9khpbwOfu6Z9r4zlTRwjKSnQtV1rdqklQdvd1YCzo087F46u1nBAARn5lBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdFsTuNeimaSs3CczSHbVkvns0Qg/fpd+p4cz603L10=;
 b=DoMWPwdTkjaTIe0xXoIuNmtzkxLqs3jgnAgz8KwT6I2jMAOhIlFc9vt2OaDJrs8WIGlo7VTRS7ebX+i/gUNBa91F8NHv5oJx8UDU7sJsqvZjXr4UCKpNdG8mtqLEx+qY+viTDiz5tG6fLisC4FbvcLSOqNcicgVuMytUaHiI/efYgIQ0cDX7MUbeXNy759Lbg3s3ygMOjCpbOCferUouTnOwRXALdlkINGwdDhXkStiFTkg/QbXUeyGSI1T07klo57iSKO6njrZEPO2TKjZS+8uhp969sH4ZAZAA5dQVhLHj/Z9BhtRJmUD9dyrpznqdgT1tEPuFrjcObQQPhU/iNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdFsTuNeimaSs3CczSHbVkvns0Qg/fpd+p4cz603L10=;
 b=ZY2DxWdzxFCl/a7VpJPLA9kZJTR0mVEPfmUXTl03sfwmKM1MqBuo+xBLA/sNToItIFkJ0gYNHSeZBqmhkbwD5wtaVq2ifuk/nlYfyQgQa83i3awZNP04x4jMQ2xkuTRbuQADAAxqU93tRohP1IHj6E7zO64+W97fKe0oUt0DxdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:27:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:27:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] selftests: pci_endpoint: Exercise MSI and embedded doorbell
Date: Sat,  7 Feb 2026 02:26:46 +0900
Message-ID: <20260206172646.1556847-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: ab121dfd-a2d3-4cbb-ce0f-08de65a4efc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9F9jVztnj7ifabyRTF9aIhcybVCA0uyPYC7o0838yt6QW4klr2hb/CWioB0U?=
 =?us-ascii?Q?fphNrtlXi6QDuGXId6H1cRWnEIxyZa8l8/ogX1JvFFYN35t6YqW6rgiQtp55?=
 =?us-ascii?Q?tbTJT8XzcpNFnbut2Tk/NtniVeVMnqTvT5GUfxLpVf+vse6sUbgKqHYtzTaE?=
 =?us-ascii?Q?7IXaTI/7fapPRpMbdlaGD1LU+UW45NZ2ukIp5NS5mRoYZ7Py8WLJQd0AmxXW?=
 =?us-ascii?Q?OCfpFPNabxI/HJAGDbUZ2HCTTqsI5zCutad/f9dZqUl6ZTFQgPliDXOrpkIH?=
 =?us-ascii?Q?zUFTLYMhKuKCy24VUbc/77YRnwF2yl9ywHKkWswh6i7kKh28cO694I3aaL8r?=
 =?us-ascii?Q?wA7Oy4kV9zEWnt6xTirP+gpbvCRSIWN8lx8iTVeOiR5p1z3SmVWLRVGHCnl9?=
 =?us-ascii?Q?K5VD8r3SqIMtQ3gnZpVVt214+us2nnqSXZOj2JVioaOTpKZKZt7OKChVox6N?=
 =?us-ascii?Q?Etl8c1+nqWJq/7zgA+KfvsovGfWCazU9HxjGhJqSGe67TSfYx+kC45vvTwmU?=
 =?us-ascii?Q?CKlszytBoX5RT3FsiljW2yVPNZWvd/BdV6yzVv0KboAXE0vhl0S8sjQ+MsEw?=
 =?us-ascii?Q?vfmyxxhyEXARakho7hPxNTMxHERz6z89A5pT+rVZPL/OcbltuczjwdqwEVK2?=
 =?us-ascii?Q?nfhUitYZZrvQJztkuIwTkC42HweDLpxlueZTZHPzY3zJNifQLeuEEtT5ls59?=
 =?us-ascii?Q?R6sHcICzj4FHs/HxZUn4QIwTbIEOhjYTjLSAmb9uNAYp/EWUisgGLQSZu1LU?=
 =?us-ascii?Q?rZxs6FCM9t++PfUBI/eYVuE7+a8lOo6ItoaxOSigw/zMA2tyHRbvAM4t1Vyv?=
 =?us-ascii?Q?gKGNSIdqFmD01XoQdlAR91tLGnGur3IaBmp2X8AH1u91NqbAtcSzDzzmo/68?=
 =?us-ascii?Q?0GZWiQiDImvkpjeUZUBs9TV0FD+HrY27tYIEXf57itGluV99ofMQ1MwQYrUY?=
 =?us-ascii?Q?i4IrKCw5YQv1R/j2Gvlhzzo2Bu7pdkXrcqulsOevgjLIm3wMBMabCbKuW2Ed?=
 =?us-ascii?Q?B2AsuLp8onvUXdqAJ3Em3tD6CM7ZU4UEyAJzKB0GQdifGJDIVIH/lwgXU2Tp?=
 =?us-ascii?Q?2xA2j5XYJOPq5I34zITgT5U1Vz0LSEIv5xTX/7JMy8Fr1yZbeXj+R4n1Pr1q?=
 =?us-ascii?Q?XKM3fUcgzNn62EdehdZZynK7+yeezMYRJbA++D9vmyng46gEtqE6Vlx+A2em?=
 =?us-ascii?Q?KkZ2jDTmWJSUna3fRbFycuieSSqJdoLdWiQtkKBRB6Hr+810dOX1rpksNNS7?=
 =?us-ascii?Q?446GmR/OlBYsbE6AODR7xHqNrvjVxifZDTQLYteXamCwMnruOSqY96gYvUBA?=
 =?us-ascii?Q?e5jWdiwbGF8F9V2VvzYZf01TE4Dy6Owj7LNj7LRoQHWt9BTnEOyDpqb7uWbB?=
 =?us-ascii?Q?Qnvt3A8d32enOVk7EqI2IMj1w/Gl4v5N3BWBWT4Ym0/XUy1Qj2LxemdSLxmN?=
 =?us-ascii?Q?ECpLbJ0d0hsMXUCXTsG1Ffim2pS5OJdoOJ/yQkkZEZfUfn3xbbAM7DH+47hS?=
 =?us-ascii?Q?gpFm7qWofpTAV/sCJ6cvXXum0xlh3nWEuZwjERuB9rC9RBYrB+n6RRu1Wj64?=
 =?us-ascii?Q?9+1fzjF5EM+Arw05jlw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/t/dNlTrU+X7/kLus11C7LUdceLm6YP896woQAbxRVTpQDyTL7ZFYlr9mkq?=
 =?us-ascii?Q?tsZ4xtBhK207GXuNkWMSbZ+4oL+5yfJT9qs9QGkH6qei7NjRHgoklEEoLuxr?=
 =?us-ascii?Q?CwmnX/u9FcGBDgc7D9G2D9n2KI+0BPFV4rIFDA7b8SzJpvq9lowmUkH5ePB2?=
 =?us-ascii?Q?scSBtYT9msKJu3iW57A3Q4qP4XsE/apVf/ELvD/EgKoesLSTepyCIcTqDNmu?=
 =?us-ascii?Q?a8U6mk6+z2MKHgQW4aWQtyN2DbJ2C7IOvvNlV5IinpEC5aliqPvxk9d7+hJe?=
 =?us-ascii?Q?ne80Be6SEHh0eXpgvVkDsTmwr1X+SvvwZCUYa2nXNzHqUAqrkr6Z5Yn56d5Y?=
 =?us-ascii?Q?F0ifaMMKUyWSgIYt/ZNFJnznlJEsUl79NRBc4h+ys1xeuZRARNTeVB4+Y2zx?=
 =?us-ascii?Q?1WBdo77qdc5MmWIfdqX1y7kmctAwJixAce6Qcx0ZyYvQk8KX6mrW+jbN6ONN?=
 =?us-ascii?Q?ztMZx+Xx1Vet/wc3QtVoCA+sSe1AohXYHp52ZwZ49Q4wl1EIHT2M/x+W2V0R?=
 =?us-ascii?Q?eQYsv19gJsf8y/z2W12PelQlkGfhDe4HLRVCfinx5oiYeDMRe4/oJTTF53pL?=
 =?us-ascii?Q?2PVKxqcVH08DE6eHJtC9sP8QZs/dJt6TXcmVi1c4VPEOl3TekhrJ5PvUyKDP?=
 =?us-ascii?Q?wLUUwM53wSfoZ2Y+s55FecL9MQ46mT005kZzSB41T71J3YIpvV9qLzqogTjM?=
 =?us-ascii?Q?j7fWFwCPp0FoWN1WPNrPpwITU4bQ/7Bx6hHf+ne7IZlbv6iUbm66bt2N+nG/?=
 =?us-ascii?Q?srCZ0GkA3K+oyKlsz1ewCQqR1tBR5Yk3n2hdEbf/mtrrTYQH8VRb37xZPrBD?=
 =?us-ascii?Q?nnP4/bxPEi7m4pmJUV0+WwdZJVmG9tvYOv9VagsTkUNjUH9pgdXJ+nK66UV+?=
 =?us-ascii?Q?w3/5Tks+MgglLXinmNmkE5zrAJAfxa/t4i0kbbTGOybEhqCKMFk9L7Hx+w5d?=
 =?us-ascii?Q?mzA2rErRYk1qiZ1Rw3Um+FTcMcguRYZyyAH/85exUq6+N5ZyXQQzfFlN3LQ8?=
 =?us-ascii?Q?kkUNAqbYtuzpVzgGSgFCHBmeC0Pw8iT7oCwa0epZYjKi7Ovwb73ZEd6NtnUz?=
 =?us-ascii?Q?rxvqpiWpd/4YFtD8e+9zPstz91HcYjY/5dbbJZT37NKeIJSjmjo39iQD0esr?=
 =?us-ascii?Q?52Bl9axSZEEaZslGPoyhhvCUvAqHZycmTP8DpFPSjIziZh0afVAicDxGiFth?=
 =?us-ascii?Q?NUe0FjoYkdRfa+obxFZd62n/x6/UmLKtMUaafkR2fTEVGV3xWFdGXfcIUjLH?=
 =?us-ascii?Q?Us9uFsRLM4i4QDKJuaz0gQ2d1HFb4/n+HHxJsUnGklzVTXqiKUo86KWmQok1?=
 =?us-ascii?Q?zrfi8NM+8y9yxlvFwGzh+diGnCh2HcpfTop7V7l9KvYJT9q3RNQzNtDICn8V?=
 =?us-ascii?Q?9/X+tXirsk7SQ9mDokf5bshPQVgfG/LGo/JN5G9nwibKSO6vF6VBCM7wRX5N?=
 =?us-ascii?Q?jKSrf3IBW5uSQ4GVGWvJQUwbMclmI2MSMyXxuWxgApOuc1h+rRqS9mxT0VZL?=
 =?us-ascii?Q?YplsqCvXN+FtmSS31cy2kkWv8GfeP7qYCqd8zT94ruvYqtAnSU1ZgXHDQTf9?=
 =?us-ascii?Q?dn1mR5NNKH4U5R4/i6xn+jsvD0ms4gDvjQEMoMBgx+BQDQOhRhUkyUYkkxZz?=
 =?us-ascii?Q?y+CrqC9zzEsNiWzfvjHWB3sYkrDBi7D3JJfEHpVQQBmsFfRLdpp3pJd4kXTn?=
 =?us-ascii?Q?tXBoUlwPHZyE2g7phLphjMUG3dLfULZUN6C/uiRyzT7gljj+JLoCaM03btnw?=
 =?us-ascii?Q?fMhR653VhT+Gwq419rccZsIE85P3YEP4XwdcfNYUq21/EDYTZSDZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ab121dfd-a2d3-4cbb-ce0f-08de65a4efc0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:27:00.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXtHxtY0aSVn9Kclol7uECEG/vMEYPx+R9PzXxDJMsP1v/c5FsDRU/H57rvHu17q2ObOGMDjb9nEc3iYfirgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8795-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ACFAF100F62
X-Rspamd-Action: no action

Extend the pci_endpoint_test doorbell selftest to run in two variants:
  - default MSI doorbell,
  - embedded doorbell (requested via the PCITEST_DOORBELL ioctl
    argument).

This improves coverage of EPC backends that implement embedded doorbell
support.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../selftests/pci_endpoint/pci_endpoint_test.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index eecb776c33af..b3c79fe3b828 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -268,6 +268,21 @@ FIXTURE_TEARDOWN(pcie_ep_doorbell)
 	close(self->fd);
 };
 
+FIXTURE_VARIANT(pcie_ep_doorbell)
+{
+	bool use_embedded_db;
+};
+
+FIXTURE_VARIANT_ADD(pcie_ep_doorbell, msi)
+{
+	.use_embedded_db = false,
+};
+
+FIXTURE_VARIANT_ADD(pcie_ep_doorbell, embedded)
+{
+	.use_embedded_db = true,
+};
+
 TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
 {
 	int ret;
@@ -275,7 +290,7 @@ TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
 
-	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	pci_ep_ioctl(PCITEST_DOORBELL, variant->use_embedded_db);
 	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
 }
 TEST_HARNESS_MAIN
-- 
2.51.0


