Return-Path: <dmaengine+bounces-11619-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Mn2AOnXM2qVHAYAu9opvQ
	(envelope-from <dmaengine+bounces-11619-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 13:35:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99469FC61
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 13:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=am53R6QP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11619-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11619-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7223F3056510
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86F3559E1;
	Thu, 18 Jun 2026 11:35:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752F19DF55;
	Thu, 18 Jun 2026 11:34:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782500; cv=fail; b=bnt7JD2rJiy5sXc7lmBbC2pfx7DQjq4raWNCFLluHkkZQPLtJedjmCH7niM//U3kNUF6yEPHO9vM5lhLUXCtnD2UAzgpYEqb5XnTeamsrB1tVHYafv0cUKX/VZINjpyeQOR6k89nuMJOhQTgBeTpTWaURzFTJgd/rUk/I1u2epg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782500; c=relaxed/simple;
	bh=Fmdz/ONFmTWIZMkoTeuDi4zzHX4wMaXjI/daRpbcmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8YmlFwJnvsTmb/412b8tINfRvkYqdbRY4vEeImsUbd/PxSVt2UhE8PVvrY61UFRtuKryaEYr7OuzcjMw4fO5TMXAmT2bna97qa4fD3t0jyZcJ/JjwEUlVgEOhceVPttNbs0PkcbVcaAElaL2vscMQN7Rk/xfOYyWcQy282Fqxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=am53R6QP; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IB0hBo4023140;
	Thu, 18 Jun 2026 11:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=J8uc01iZ7ZuRwxnZyC5bsNjGP/kpcD+Bpro6ST9av7E=; b=
	am53R6QPrEciR9KXU8CurFvuyBJvM3uX/wkStccf2kTRW45Hs0D9V4PLUHw28FS+
	rVIEPLkzqLz7O1WjfKjjdAywz9Sf9OY2Kc3rP+VOQNkCbeBFyUSWNli+OZhQCjuL
	pXRIku+bUxwXBeZCLJcZaI+fzc4OgI7RcJCE6fUTGW9T1Qy6BeEKYf5PAbKaDfoi
	Q+tVEtHF3Uod13qxuEkOtNKdFo+F6oWntHL2Xe7lh39nlktxlzAPcpxFrAzlqBiX
	D5PwfsuE8GBTdcD1E0cjq7Z44GeK5wUol53KUaWtybnMM+XSkP9+pUPqdw+046kN
	y8UEM01+atnXfqxAcLujwg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefc2fvf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 11:33:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fb0CGsvJrKA9K7ACSQlbk1T1VeCdXmXm0FUt6tSCSvCneTB0eIUiIfIC6AXcBLX7wRVwPaM9Q2GNUCR3kN8LT4rZkLIgOWFjzHlHFtREnvc3B3v5lom+/7u2okNytjWKDfzh0nwBV17+NXBt95Cm1hDJH9n6QkSkvlu3VINlHNazWeI0tLMIJxtNfzJ6TfyafhEMfYvpPAJqKzZLNnlT9ZMq3D+ZwBHtOLVbuUldJKATSbK+Kj4Q5f0GiiI9o+MJgW9m6I6dv/VH0i5313Z/RXS2A8AHEIIC0DMWBJe/JmfKONeiHpkRxFe9NkeX3Y7vmJ9EEEIVkGOQ5uqqLl6uaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8uc01iZ7ZuRwxnZyC5bsNjGP/kpcD+Bpro6ST9av7E=;
 b=Ifx+MQgbqdfMeNGoMPAS8USS4aG+ywj/oK+QHCTPzZtPZR0l4v5OTU17vu1vFcehuNGzpbH8nzI0GHN6/71D/5G3XE/Nc3a8GbQ4YzkvL3oPPAAtDEEqK2SH0KDBicUiDl88wtkqLxYm4ATxRas2WAlwiKKDnQhFelZljcDrDoILyxvDFvT6i2WDJOlAbtaD4PuXRn3RbUVnXVV0FhZHlG335ElE62DbWojGnO8N4GtnLoSuqaOsm/pD2PlhLnSbP/BkTC1i+J8vuoo0D0Y3nO2IuTrW/YSYCmfGEcmNSpFfCrICHp7XvoUwh6nIg5SBVe548IX/t4EUT6q0J6FhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 11:33:17 +0000
Received: from BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca]) by BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca%3]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 11:33:17 +0000
From: "Bogdan Codres (Wind River)" <bogdan.codres@windriver.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        dave.jiang@intel.com, vinicius.gomes@intel.com
Cc: xueshuai@linux.alibaba.com, yi.sun@intel.com, fenghuay@nvidia.com,
        dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, Bogdan Codres <bogdan.codres@windriver.com>
Subject: [PATCH v2] dmaengine: idxd: fix use-after-free in idxd_free() and idxd_alloc() error paths
Date: Thu, 18 Jun 2026 14:32:54 +0300
Message-ID: <20260618113254.493582-1-bogdan.codres@windriver.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ajMNBgdsvdLPCt7X@lizhi-Precision-Tower-5810>
References: <ajMNBgdsvdLPCt7X@lizhi-Precision-Tower-5810>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:803:104::33) To BYAPR11MB3606.namprd11.prod.outlook.com
 (2603:10b6:a03:b5::25)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3606:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f6823d-37e1-4e90-3241-08decd2d645f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|23010399003|1800799024|38350700014|56012099006|11063799006|6133799003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5nNc7ctK/KGdOUXrZ+lluOeLtiKMyY0q7E6BGegw8BwyTPkBpTrNJWEILi0SAZPsUXdxejLEBmuqp7xeFes6cQslMRJCAoLK5vIPAIco65r1svE3O2EKhFFYqz9dbcv5QiQBFasW1vwYhSLgPl+Z+dm1czpwS2l5p91gmF1eXb+wkrSxWQQdq9ck/qafk+RLMzPeQbpC0kIb+DeMpVIUMcVFKpZ6hCV3cUBwvxwChG9LuEByzTRlLlqoN0shIwOwN2af8eICsAu/a3lTD35oGldVfaM7Rcb6eVzeRy1m1ChUgNRZHzWFrukMpBgbh0FCcHbTK+nY5ecIqqBpYdp49shLB/KcFtq3tsA6RNziK15GpUWIiJGPm6BTEaXBPXShOZlTqFutEsaXZiY0dHa458jJbKWdRUWZnbbHGLgOScfhEx668GZxBgLV6J+ZRwkRUw5CVDwlqUqs6aIhLAE+/g6UiuAWmLfrM7UTpLUkwC/4nvCBL9AkwGfzNyDFatMV+GE/osp4A7RDWtS0zGsDHmS7SFfs7CpP3Xv/F3WOXScdEZRnz8rkcuzh5C2DBOF9ZNfYCsDg27IMyM09jbk0O0SSYnDswA58x05v5BTU6EewQeeBdZ9f/+XHOj15mWAnQlxCqkx8DJo9thBj8yQpuxsjYiZ3I2d56fl2clc+tXPQtMhHyfQQ6vywa51epjLJYZXVn9k9vwPNqfYP9yBtHTQZ5Eghn3QACQmss1QOQi5Cv9GO2HCZ2HNrMapXzL6X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3606.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(23010399003)(1800799024)(38350700014)(56012099006)(11063799006)(6133799003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vp3X+THlyYQ2B7fi5v0MnJov4avybewti/bcJUYtrTyU3H0ppUJqWpSjpqHs?=
 =?us-ascii?Q?2KbqSDcbFwZdj0lgqbzz21JuMQyZdzcuRKh4AvYzhHYOyXXkIVlOGGWdtVWD?=
 =?us-ascii?Q?GWjpjRJSdVcV6TXN+RRSR0+cVrB8V1e73Bt0LjcAfGkoODfUprkpcarf/IG0?=
 =?us-ascii?Q?dIhtJMtyvhbE4rhAgoM2ZmOi1IWEGfi/Q8Be+aIDgGHXWB/6ch5PWHnH5GZp?=
 =?us-ascii?Q?bSMA19yAnAPyJ4WaFeCuu9zezUw+9sEK/UJ9HtjGQ17wbtFYi7+xtk+8eFDA?=
 =?us-ascii?Q?9fqwd3actFjqLkGCLbDDk8Q5dLURIbuhlYy7llHbX+2zLv78ZX5Mqkl/SnZB?=
 =?us-ascii?Q?+FbxbAF6Ve3YXJqHBkyackA9Jd7Tc17XjYsk0/xTYS6Lzo4Hvua8eX7X2Cku?=
 =?us-ascii?Q?EMibKWcKQ1iYOmGkXKtRd5H1YcVdXnkEAJsnkjaMJk5iBlgRuv7RMJaeC+Y7?=
 =?us-ascii?Q?X5e7Zmzzn8wjoYNDIpNxuPMGqgSllo6Z0mAX6hmUvGD9cLgL+iC1ikjnzEvE?=
 =?us-ascii?Q?YTo4ipk8HoiXgUNlj6h3yoFtvX91I6CUauqZdg4b0k0gleZ0vOPQnkcGdwSO?=
 =?us-ascii?Q?PyJLiqN8SLpsQyvKtQD0shN2Ae3lFGDtgoFVk0CZUzms7g75MKrvpR3Q7L6X?=
 =?us-ascii?Q?6IEfww40IbO8JtwNDH6MrUIqidHIB6w/cbltvQfm344tA1YGZCZNFuW3NLmH?=
 =?us-ascii?Q?X+RXR+7LRZnEnSSJRzGqlZFTUKnB1Am2Qd+/FRqcjEoI6d+6N15eaPcVOk9z?=
 =?us-ascii?Q?j7BWtfBC7bL1n9KWHPQ+/hYFNN2lY7SgJTfw3/aTcoPetzwg10WXqeypPS6q?=
 =?us-ascii?Q?+kUxEmAXM/iVRu2kjh47HY/mJfVY82gF/N2vqIvuc4kIoQwhO5H0jSrPANaL?=
 =?us-ascii?Q?MwOQUMUt3iL6OSU0Jl/RcoX8sgQXwEg+Ztr/37WKsitFvfN3LzmqXy6nHvWP?=
 =?us-ascii?Q?v7T7nMvzytla20C9XpVmhzH3TIMIPk9EgD5UVz5I8YjlkwFNv8rAVen7UA5E?=
 =?us-ascii?Q?KZhKkdDXCKeioUO/7wiNW6R1I1DW4pa9J0z0Dxmmtlp/U+DSZy4kAnSXYlJ9?=
 =?us-ascii?Q?X+2Uh4z0mqCz6yY5M9UiWmWFshcnBj+JAFatFDna/VXlwbCeSCTcBRh7kRno?=
 =?us-ascii?Q?JQ5CXGJKleqt4k4DAqetVwb9cu8yncrgLU11AuraiuTJa0KwM1wSnSTkS8Uj?=
 =?us-ascii?Q?fqI2uzz8C3HD3i/00W2c4My+GNFidcTprc5+FU7w3QFfWewgNFzssFFvSYrr?=
 =?us-ascii?Q?2/9Ej3aHS6IZq8wJnDoAIzTy5ncvRbns5W/RG0WSmmfbV4iigBfFCsBQYTRw?=
 =?us-ascii?Q?DIL7w93hUTraTgzUHsHb4iwnYgXGy+Y1stCdm1MxTvObBHhInMfauGgd2yDW?=
 =?us-ascii?Q?tYdoeLJdt8Q8Ze8hGqm5bIxQosJZlB96q0YwYsj/RHUW0bXcAAhE/dtPaXmm?=
 =?us-ascii?Q?ysl77DGhJiuukPYmqyRcsdcLyeNhrF6bzkggmTYG80U+wWK+vgx4Ne0Mravu?=
 =?us-ascii?Q?1TaANQVMeHiAPpNUzIYs8+lkWadmcnLw9CJFoJ69VsJmHrSPc07wwq2T7cun?=
 =?us-ascii?Q?dygoqNYZJyW8yef0JMl0gphmGX4Y9hD+q9gljmIK10qOiqqkedd2XputMGG0?=
 =?us-ascii?Q?FVI72qGPFNix4lxokOIw9Ywls0w0WDNYuRbNfp5KjNdnuJOvTlIIp4Wowl3U?=
 =?us-ascii?Q?fZ61KJBi0AKstQBv104QQ46tNlAPovXZ8NDnQ9acPH4TqS0nsGWUFW603jHi?=
 =?us-ascii?Q?VurkoUc8umdz5crEYVL/YN/NCFaN9wk=3D?=
X-Exchange-RoutingPolicyChecked:
	KJM+XHf6D3t6CDFY2wWs07QAIDxPkNZ4yk+AHswC8zmS9Rmy2WC6aZtJON/YEomqtwCEsvQzcZZkOaPxRX3aEvSsWpWpufc3cOnQ12esr5dLGbTwOKhBiwStCCKlxCv4T0MQpMBPHdQRYYeaaXmPV0rDTB9vTOsYsaiSs7eqvw7RRm+oGGXpjxE89QQb785CxNcjycI9V1LpwjZvvbsxyO3UZLD9H6zMnUU5Q/cO+tSNiIxC9e0r1EWcr+2dZcTu6MrreTxxuAVCLIDmWUQF1CG3sYuJ2k+pv5vKhgY9Z2CNi+IApEvTChPnOZa7ICu8sVaO65rptCrhlCITgBpOSg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f6823d-37e1-4e90-3241-08decd2d645f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3606.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 11:33:17.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rvFG/517b2DhOejcD++dJR3SrcOgd18ermoj3OBW5YjHMjx4bgrw1cOrTwM6F82PkQRm/EVR2ClIMmiPeJxX0OOdL1IWT+bVQIcWwTLvag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEwNyBTYWx0ZWRfXz7Wqd6Un1JYt
 TSEiEgTD43I2qganeptj2gbBayNgbDZgBXG1dce8CNilY+7k6x+P3avJ7FYr/IjbE/5ScCvhBQV
 VqJcuvWLJl047HCX2ILgEa9c3baILSQyPVwH0vXQvhtbTraH7E0h
X-Proofpoint-GUID: 8SRtQUsaT6-shsshWjDLTGjzurXdO7mZ
X-Proofpoint-ORIG-GUID: 8SRtQUsaT6-shsshWjDLTGjzurXdO7mZ
X-Authority-Analysis: v=2.4 cv=ObGoyBTY c=1 sm=1 tr=0 ts=6a33d781 cx=c_pps
 a=XYu8HXWfxIrayFrXgJv6cg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=IRGxDHtthIZT6labGEEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEwNyBTYWx0ZWRfXzWjC9JEjUQ6R
 MumWML5LXY1D31tcwhsPIRFSgZEgNfJ8l3Zis7wYNp4i7Mmkol5kTtdkn4C+QCkglF2EbOcbjib
 wo2NGqL2h/RmW9PCCjdvXALyaetbY7qONU0O9iyKNeiUpEonRHP1wdbDcFLrPMPixDQms8UrihU
 ZyTwQkElkffRyZcAu4e3YXpNHmiEFvaH4QUZPJF8NDwXqLpNZPO275yDav0cF1nJYj/kJoHK9rB
 zxPWRzGXtlQYp+ZtQ29o6xnwPJTGvC7z84XnBG26b3px8+N2bgM2Rvi+X1n1Jfdvgxgw767lYGi
 nICc/jsnkGRklizFx3NBAdyQA0EK4UlyyTvC9l5m2hsef7AL0lzfWSzEmIXxAyY4DnFDb9u9dPX
 MdDSrWXStOUIW+kbgHmv4Y0Nwaq/E4ghrHpdBNgXSLhQZoTTymaftXVkar5qtgpebGTF7pf4glU
 QsPPujiPUJV8dFhscJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180107
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11619-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bogdan.codres@windriver.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vkoul@kernel.org,m:dave.jiang@intel.com,m:vinicius.gomes@intel.com,m:xueshuai@linux.alibaba.com,m:yi.sun@intel.com,m:fenghuay@nvidia.com,m:dan.carpenter@linaro.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:bogdan.codres@windriver.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdan.codres@windriver.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C99469FC61

From: Bogdan Codres <bogdan.codres@windriver.com>

[   18.628791] idxd 0000:00:01.0: Device is HALTED!
[   18.631447] idxd 0000:00:01.0: Intel(R) IDXD DMA Engine init failed
[   18.631450] ------------[ cut here ]------------
[   18.631451] ida_free called for id=0 which is not allocated.
[   18.631462] WARNING: CPU: 0 PID: 11 at lib/idr.c:525 ida_free+0xd3/0x130
[   18.631474] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.12.0-1-rt-amd64 #1
[   18.631477] Hardware name: Dell Inc. PowerEdge XR8720t/0J91KV, BIOS 1.1.3 02/03/2026
[   18.631478] Workqueue: events work_for_cpu_fn
[   18.631480] RIP: 0010:ida_free+0xd3/0x130
[   18.631492] Call Trace:
[   18.631494]  <TASK>
[   18.631495]  idxd_pci_probe+0x1b0/0x1860 [idxd]
[   18.631506]  local_pci_probe+0x43/0xa0
[   18.631508]  work_for_cpu_fn+0x13/0x20
[   18.631510]  process_one_work+0x179/0x390
[   18.631512]  worker_thread+0x237/0x340
[   18.631517]  kthread+0xc6/0x100
[   18.631520]  ret_from_fork+0x2d/0x50
[   18.631524]  ret_from_fork_asm+0x1a/0x30
[   18.631526]  </TASK>

idxd_free() calls put_device(idxd_confdev(idxd)) which drops the last
reference and synchronously invokes idxd_conf_device_release(). That
release callback already frees idxd->opcap_bmap, idxd->id (via
ida_free), and the idxd structure itself. The subsequent bitmap_free(),
ida_free(), and kfree() in idxd_free() therefore operate on freed
memory - a double-free that corrupts the slab allocator.

The same pattern exists in idxd_alloc() at the err_name label where
put_device() is followed by bitmap_free() fall-through.

Fix both by letting put_device() handle all resource cleanup via the
release callback, removing the duplicate frees.

Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Bogdan Codres <bogdan.codres@windriver.com>
---
 drivers/dma/idxd/init.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 18997f80bdc9..ce4d58740c88 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -585,15 +585,18 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
+/*
+ * Release an idxd device that was allocated (device_initialize() was called)
+ * but never successfully registered. put_device() drops the last reference and
+ * triggers idxd_conf_device_release() which frees all resources including the
+ * ida, opcap_bmap, and the idxd structure itself.
+ */
 static void idxd_free(struct idxd_device *idxd)
 {
 	if (!idxd)
 		return;
 
 	put_device(idxd_confdev(idxd));
-	bitmap_free(idxd->opcap_bmap);
-	ida_free(&idxd_ida, idxd->id);
-	kfree(idxd);
 }
 
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
@@ -633,8 +636,12 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	return idxd;
 
 err_name:
+	/* device_initialize() was called, so put_device() will trigger
+	 * idxd_conf_device_release() which frees ida, opcap_bmap, and idxd.
+	 * Do not fall through to err_opcap/err_ida.
+	 */
 	put_device(conf_dev);
-	bitmap_free(idxd->opcap_bmap);
+	return NULL;
 err_opcap:
 	ida_free(&idxd_ida, idxd->id);
 err_ida:
-- 
2.51.0


