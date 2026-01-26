Return-Path: <dmaengine+bounces-8483-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNyhJtIZd2kCcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8483-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2027E84E4A
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 469D73011788
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF52D7DED;
	Mon, 26 Jan 2026 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jVVEgJnD"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021104.outbound.protection.outlook.com [52.101.125.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991A2D7DDF;
	Mon, 26 Jan 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413055; cv=fail; b=fQNiS5S5Ifh6s5CDobNi0VPWk0f0VgqsJFsDRZ7Xj4FSjDTG3uK8LOb6rubI8J8tij1pxdh9NFtZSoD7Ojek1DBEqj7VJFwNlHZqL5GZtqkERWoWaHDBkc0tNIqDwP/fFFHl7wVCEu01Ksh8hnmt+TnOdaV2TUW0Xfdeto6IN/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413055; c=relaxed/simple;
	bh=m1Jcx8awyfkDYqz0CTlh4YZK6SriFrIz0wUPq/P/DIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkFwvyJZZtDY8WZ8V7SSBQthJyuqureIIda29M4nyZE8rzf8mNhNuMJRnL8f/H3zuL8TAqoD84APm8MYYjziLDY8bSf7tx8escE67jV9p3aTM3Ol1t9YcdLdmYg+7iv9ZHt74f8nkPcM9VaRf8OWOyeo3XkJb2pqwQeNOUkJwHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jVVEgJnD; arc=fail smtp.client-ip=52.101.125.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffnhiKcz3UfKe1xUUglH8ZjkLtqjMNPj6jRvMXDD0Qp5D9F/Z78F9R186FOClH8us26P1w62R/X1sSSSGPkPvXrZMSCf60arDYmFxCeVKXtCcjll9ET0zRytP2KoNruHEzkOJ5qv7hxbfqmKZfcCZJZN7j7w1j8DlVhdW+kH7lMAIG+fKDvME1jYpf/a2RF+0yCphBiazq4XDSPosKbyZOBvv9nVRPviT00+WbBYWf/wcwrFoB+yDTwKqzMUA14Qrf4m1PKPI3jE5GSGdZAObAsy0cpdnmYobtukzGYRW3lmD8cjIwjJ5N4FqEr4kcaZODAjHUlJQADkNPHox4E7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDLcLPyudPD17KHixbVdyVF/UTzyzVz4l/tpO/8K1Cs=;
 b=IflgrDBxFVE7UIt5xD42erqUzX6r/OflxUJYIYA+8lztWFhFUS6G0P06aLchjCx9QgMehEi/4VEldvtjMYzgTCjHsxXtroB2A2inYJkS8MFBJR4IorvaTh9Ipr3YX+CjNEISKWceVZ+SJa3fUVW0Qj3d3fwr4ddGAQ63MboMA95A4kHtWlTOOWSDRERt5ToiqcLsF/HFKJAXBSWzB/4ZM2vo0bMyehvGskoiq3KYpN1FWbZVpmP1iEMzx/r7UEf5BwGtheyOUKlbNwCICHw2Wn1l10FCM4Qj2gZ3nwjwRKIHXidy34jn56wUPLwQdLVrb7dp4Og0JZ3J018VmGRTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDLcLPyudPD17KHixbVdyVF/UTzyzVz4l/tpO/8K1Cs=;
 b=jVVEgJnDtJA1JXKG6MDkKcDQpWq2Xa1kZYsA4lE+iYlj2vvKnnXTBKk6iyoYqJGg3ZIlHWkhynaJNQEaznT5cslNEwTgJn531+ZkEaKet04j/hjkIC21bvWULMBF8JgJ2LU7hoocECmjTDnCGQi9D7S4LQR4l4JwkDuz/9KNgw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6300.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:37:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:37:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Mon, 26 Jan 2026 16:36:50 +0900
Message-ID: <20260126073652.3293564-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126073652.3293564-1-den@valinux.co.jp>
References: <20260126073652.3293564-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be81b4-830f-4ad6-c029-08de5cadb5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V+QHfHa3aDGZEuGViMeL2bVgVY/8kOvlPpk2lYz5o81heWHABbD7iLE+dq5B?=
 =?us-ascii?Q?pg/QfKzAKJHBJ3d+Dzx5eByu+Rpr/II5MDiGDDal0mJ00cCMG+tQXZzSki02?=
 =?us-ascii?Q?n1zccTTCqekEBjio1Tt6g2Uq+iv8vONvDntmr0Rq9AUb47Zu71IeYTsOKPSA?=
 =?us-ascii?Q?df9kzj0MswEIyG/ozIvx9J6QLXjyzgosfDDp4pzQzTky+UOzsIxsrJMp+mJM?=
 =?us-ascii?Q?926Lm+zPylXU5KZBFsVlvN+qJH6YYXO+iG5SaAHguj+TguOZv+a7u8BfPTYe?=
 =?us-ascii?Q?cqNxoYL1luGdDeajoMya22wmuRqBaT5E7d9bao0vZE8wbhw5LLgqvDzGxHRv?=
 =?us-ascii?Q?txpfxK0Y1ts5rIRt+KCVOGQfzs6+e0t69PQm0U+wvQx/kabY3rQVcMBlYqo1?=
 =?us-ascii?Q?eIrSeq5+hxdPw3JdHqWW3WmgEpBJBzTjBRUgnLP3L8aafE/bz0QWGSlZvEVW?=
 =?us-ascii?Q?xmyQZD85c3Gx4ntOZyxMtkoSvRwoe0pRcOslVaLnvbtkmMJX6v+pGrKIyvX5?=
 =?us-ascii?Q?Uxcr+aeJTAfsugz3cc2Qg+6d5bs1D5wn+5F1cQShQuKKcGJyu3sTL5hRcoRR?=
 =?us-ascii?Q?TX22uAWDRszaKjyEDPIKMQWH0XYDNUdPlajvkWITztEvLbdisEeIIKB5azQz?=
 =?us-ascii?Q?XRbQeol/ShGiHIIO1kWwttUFiUtLEc8+Mh8MdlYo9bFSWTYXLAPGilfxpecC?=
 =?us-ascii?Q?yiR73OYqb7kLVkY8n2zo6W77B6SuxuI2FOYqeJALAFEv1Oa32wCi+m1AhLus?=
 =?us-ascii?Q?GDce8nThfjczbR2yCsQ7mg/URlEPfEfUCOdYnIie9Ufer2gwen7Z7UuHB5Nc?=
 =?us-ascii?Q?BTFXzgWXY3etyRwDPGXEsiOvZ+thmWzCrftvUyEkim7LSyTeQCyn/mWi/GNp?=
 =?us-ascii?Q?W2S8a/cyuXi3zHj4iTheV1/iSP0/m4Fb4dKay3NpmVEjJHysOAobVLY0q5C2?=
 =?us-ascii?Q?H0/NhS5egukJz1s4/9hl4VTLgReV7rmL3aVljr9Be7OXaZz6kFR5ugtGR+US?=
 =?us-ascii?Q?t2A459npHA5BN2mben1Y1W0kQdhAZDfFXXqQNaUNkQeYDVTnuFRMbrZcgq+H?=
 =?us-ascii?Q?HjuIkxg7ZmeTaD1nVttMGN6imucPGO1Y3AhMEVQkGD7OI6B+CJBA2aBSghGd?=
 =?us-ascii?Q?tvIk194xlphFnm1+7PrOz+cOzmPyFq7XprqFETRr+9JZgctkY13WhbDTPhb7?=
 =?us-ascii?Q?hu02sF9Sz3yMFMrSYxNuJiq5B1ZSUUdN2d34Gt/7Yj7bJWuBz6u0MDCLlDTy?=
 =?us-ascii?Q?uu43eKMTzedf4jHnBXop/yk31qvxaLt9wlzEV3i2NqVyz/lqOuwvDm0w/reg?=
 =?us-ascii?Q?a5yLpyNeV4FGTI47SjFPtKJ8Nwujcx65Fs79JRXoPQZUgKi9jRAg+DBZyGb4?=
 =?us-ascii?Q?m4w4DjqwFj+YrfB4MnUdVOrZSfJ7yIXgCOL5mAcJdPeDPFTTPMNQ652jLJ6p?=
 =?us-ascii?Q?1XwJ0ZjvanlnqLJ4z7A95fzs61RZk0C4AhFmZHUqvt4WMt/89MHSwcy7C4js?=
 =?us-ascii?Q?xyyYztxL/8aanMvbV8UnX7lTxlHBO91JGAiJ1MRAoSG7B31AsglofFVGJggA?=
 =?us-ascii?Q?Vqk9RDRruLB4tcbfykY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jiKNzhPLTGwSQ6Lr37VlJzuIkaE1pAlosdsiwOQC8zrd+lgCtcDCoKPmVPaX?=
 =?us-ascii?Q?BsrnqhhBxpNEuzzT8Jo0lQ4LP64+zapJnSsfn6V5HewBagQHXWjM5NFaXn3u?=
 =?us-ascii?Q?55lPVFvseAd4/8UwsIQAoHdjksWYHOyO+2bPl9qxbSQEIJi31ysZzV0+7diH?=
 =?us-ascii?Q?AbRuci3GR22vct/N/1fsAFTL/Lo2M0Oc44siLY5cHs2WijhvNS4v3a9aZxTx?=
 =?us-ascii?Q?SSwQ8/P2j4zdTuGDrOs2n2BM5/hB1sCUI4xXVgzW4SAlGG/4zsgNm3OUTgOn?=
 =?us-ascii?Q?qLoXPF0SljPg+LAGAngVzQXEKF2qhpEuW3f4hM3oh8m6Y2Ye8KaPH0HrQGjo?=
 =?us-ascii?Q?Z6btcuW+ZBjYhbIICOCcLbRl3GNj2iiCSep4vVAwH9XjBrF/XZkgHy4wewf4?=
 =?us-ascii?Q?zAerM+mwWmrPno2svaO/7Vl4W30ItK3dwTwK9hLeRWDTmyLmV3YorPuzqTPi?=
 =?us-ascii?Q?QY3VhxVMkr375m2WIQnNkcJqhg1IVg/T+xhJhX6PicPdWse8xqBS3FKxbBRx?=
 =?us-ascii?Q?IEK4EAkFwvUKKtG5veq6O/RlkItuC6Sfl4t+F/V+nhF6kA1Yk0/PNRS4nDcD?=
 =?us-ascii?Q?+zn+i+DcBAXg1N1UKMNizYgeGN+p1yWGUh8xQcRHsuXjO4v8JUcjSk5M/8/T?=
 =?us-ascii?Q?kYdWi7xiDrQC5IoknkhpKipuF1wApXy+mZlz/MkaYKCdjizpSuuHRiS2VQhy?=
 =?us-ascii?Q?MR5ZgEP5pUEkTPyA6ycs5ui97Er8vBd1MF/l8dMITnO8ACx7/7Ax737gY1hM?=
 =?us-ascii?Q?a8Hx0xlgvJjgiAooUfHwkXdOowtbTagXyB0PPpUL6Zsg+XEkUZPdXoF515yw?=
 =?us-ascii?Q?4bOv6JiXHCLSZJ8ORmxnmsal40LQPamyRof8/qRID86yV4IZltYkXSWIcAS/?=
 =?us-ascii?Q?gPERLw+a0E1UdbqoJHWPo4yVPQmHnsVj1rnPlJFG7l54ZZGBE/X6evPIZ8Eb?=
 =?us-ascii?Q?df4pJy+UDv0WPaf18Q8t3k9j3/gb8Hw7Wn9XHclKg7R7o45Rd3M77I2b8fj4?=
 =?us-ascii?Q?8JDqjz2ja7bvS6fISNdaFPPDRWeSbDqCQa2+p2GnjQ1hkPj8NXL04Y75GrVv?=
 =?us-ascii?Q?3V7AQjSF22LxP+UJOCwnyxROH6VCayaYydu4+SQcFzNPYD0n+TH8T2/WhqI7?=
 =?us-ascii?Q?xlIZlikr4jCVkL1LG92R21Xx/bgR2IadsOdWgzFeiu1toFexPIhQE7cAotd2?=
 =?us-ascii?Q?MsBMuWGk8kUIj2jM+nXpIDN8NxrpyEuuZueM4ArG99CzA2SGLPiB9JPkIBUp?=
 =?us-ascii?Q?hW91or4sU76U/65aitnhTjQRHMpJEj+PNCrnfPmhJtVu6pS3PldQyWF3s+UM?=
 =?us-ascii?Q?AGUiXh/QFPHMycd9OhlWGrpUbJAFiZMDK6K3ZqjXNOE0RK9aNKJ9xVzBdw/0?=
 =?us-ascii?Q?e+BM8vVjl+0ZrXEoveSrL2jrWU25/8ZFD6t1NY798wTcDDPug6EnBfbptXCU?=
 =?us-ascii?Q?B7hu8F4Z3XgqKiwIoFynA4JH1MwN2bNLWwfxBntF4olLyN4hezlsW6vtGNAu?=
 =?us-ascii?Q?RMRVjA6xc4cIm6hUBdJZTbNIGhL+qL9DLVCQp5O2Z7CkfEUUcoAI+dmA78Ks?=
 =?us-ascii?Q?r7d+fQNcf228hdtNcrwRpFrdHrO+oFI+Tc5PJol0kfrPAprLR7eXKWsol8Mh?=
 =?us-ascii?Q?Ob3sCLyaJ4FMtkarqS2GzIloNzcG4dYKuKic6PYhHQEawNbYOVFrX5FwzZEj?=
 =?us-ascii?Q?wlHPLsLNERnYDQGzY4sPKNw4jZP4sVyZION9Y4tqbiufm9sQSjVYWjW5AYw1?=
 =?us-ascii?Q?PLmWxJzt50ug5/J+NLYOoJEUIJAorm3g3XwewQ7GbZAHNm+AwCks?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be81b4-830f-4ad6-c029-08de5cadb5da
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:37:08.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFhmKHLWQIF0x2Tnq21ZSCgj+VecHyfPX8Grvd7PTnlJBkFRkBi50rQnCYdUEkB0b94PAFabn7474ojjOuNJ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8483-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 2027E84E4A
X-Rspamd-Action: no action

DesignWare EP eDMA can generate interrupts both locally and remotely
(LIE/RIE). Remote eDMA users need to decide, per channel, whether
completions should be handled locally, remotely, or both. Unless
carefully configured, the endpoint and host would race to ack the
interrupt.

Introduce a dw_edma_peripheral_config that holds per-channel interrupt
routing mode. Update v0 programming so that RIE and local done/abort
interrupt masking follow the selected mode. The default mode keeps the
original behavior, so unless the new peripheral_config is explicitly
used and set, no functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 21 ++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++++++--------
 include/linux/dma/edma.h              | 28 +++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 38832d9447fd..e006f1fa2ee5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -224,6 +224,26 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_peripheral_config *pcfg;
+
+	/* peripheral_config is optional, default keeps legacy behaviour. */
+	chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+
+	if (config->peripheral_config) {
+		if (config->peripheral_size < sizeof(*pcfg))
+			return -EINVAL;
+
+		pcfg = config->peripheral_config;
+		switch (pcfg->irq_mode) {
+		case DW_EDMA_CH_IRQ_DEFAULT:
+		case DW_EDMA_CH_IRQ_LOCAL:
+		case DW_EDMA_CH_IRQ_REMOTE:
+			chan->irq_mode = pcfg->irq_mode;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
@@ -750,6 +770,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..0608b9044a08 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -206,4 +208,15 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline
+bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..a0441e8aa3b3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 270b5458aecf..d2938a88c02d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/*
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
+ * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
+ *
+ * Some implementations require using LIE=1/RIE=1 with the local interrupt
+ * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
+ * Write Interrupt Generation".
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_peripheral_config - dw-edma specific slave configuration
+ * @irq_mode: per-channel interrupt routing control.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_peripheral_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
-- 
2.51.0


