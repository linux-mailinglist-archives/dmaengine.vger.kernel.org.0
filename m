Return-Path: <dmaengine+bounces-11517-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9fvAKrrWL2oCHwUAu9opvQ
	(envelope-from <dmaengine+bounces-11517-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 12:40:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D2685648
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 12:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=JcSPGZKs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11517-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11517-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6797130214F2
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E530F7EB;
	Mon, 15 Jun 2026 10:40:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F82F8EB0;
	Mon, 15 Jun 2026 10:40:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520055; cv=fail; b=YCq0rmrnosSSmfznG2NujBGoEreEZ95rBxVc5/RvS9nJxSOSG/wVg+zou0L/LiRfwo7FquOt6Sl0CoAX6ITyZvurMeTiMqf7t6APD6ITwd2NZMi92qdjBIldKVrazcKdbbQQcFHVulArQdF/EkWPf6gy8UU2jKdr0GDmtkuSTl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520055; c=relaxed/simple;
	bh=LuF+ZOxDPpG6AlbxIC/AweBW1YdEnISIgG06H0gRKbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0+pMCiEUSbwrL+YQJrWd9OmAMfWK2eFUzCKIiMxOF+p20GMXK91PX9aC0CV6BEM4x1zwKrb2KfbASBJDMvB4nzCeq83YyvcipV0hxbWpEHUfInyOL6dzrbHtwUzuI43+pyGIAUA3ADGspyVW/hyLyqAHAmf8U0pr14hqWwvjUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JcSPGZKs; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FANYqL216889;
	Mon, 15 Jun 2026 10:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=q6jESN7Gx/vfvvjYzHHURB2M3AYaIVamWlCd+3U5KiQ=; b=
	JcSPGZKsm4kL0k0w2mqc751mA8hKW4qoIkBwuY4Go9bVABOV9M760HxHxduNXnhj
	4y2efs3AmsSEnAKqyrsaMFp+I94PGzOA+VvdiSQCHfvjTZhu2JCDP1O9jnaAdQv1
	lcM07KjWphpe3miusXJYWK2ON0F9k5a6IEjs3B8iZvJnflHcKYQOf0x1WeCm+ZE8
	WjJM9kSfyGEOMwadZ2fsrn8NDdR+C/kJ79o0/LGbPS4tBtTVxRY2ODM/tMwphxb7
	cahYTklJR5L/vvmLfsPggxrRfJMs7sJ3oatlcwAFZGJgMXESDnfVY5Q5PUmHBSm0
	2z0lrr4m0J5KVhUwR9R7Xw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4erx63tg2g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 10:40:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCzt/+p424kUqT3SIN0YD06stNN4UMNJYZS3CZduC6XI9ATXXUpvwd0ANJGiGVLiSg3o78rJEATrIWQnbMqU2JaEZsnmwpArfSB/N5t4tg5SuV93te2WJD0y0jpRzcjXRv6L58mnJO2A7NywkiWa5WVYy4TaJ2LZfzssF7q9gObCcBIEwErFN8aFXcEL9ON813ZOe0YPH+H1mzXq+c0Zbe2qWRsqmWV83mNgumOW3HbdUov365Hk0/PEwF4Nz2r4MhLsz0epU2SnJebqyroSbeEoAnZffZDA64jWtavyRQTDyvOzpr7kSvghbEslSl6Fj2zPK+aW40MarmO2Jv/dVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6jESN7Gx/vfvvjYzHHURB2M3AYaIVamWlCd+3U5KiQ=;
 b=hRNX9vLO7Yb+YCZdLHECeFnaIKbwZKbtgcVDQ6YnuWvuzAeBm0NhTGDoP+9CmUdgwKg5a05IPqgifjewzi7ORstGTDyqDACYH/r/buSE4THfeO64qFIWbfWHu4xzF6H+5sxNiONMSaJKEJSHONOiaL1Agc4AlRW8rB85wWBSvM9G5UB1O0aNFFpPgKind9TzoQlm68Z5eeDca0CLf+fnz5XEUkojcHWektWoIIa8SeXdcbIe56Dym1FaKU1fhiSIb7KBaN03CEFggGTJF1lOCX+T6+F3LVK9oqgEpFY6HcI0lXpn7ZOfJlJtiscHNIg6cYib/whTK1nVsTKN/DwlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:40:06 +0000
Received: from BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca]) by BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:40:06 +0000
From: "Bogdan Codres (Wind River)" <bogdan.codres@windriver.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vkoul@kernel.org, dave.jiang@intel.com, vinicius.gomes@intel.com,
        xueshuai@linux.alibaba.com, yi.sun@intel.com, fenghuay@nvidia.com,
        dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, Bogdan Codres <bogdan.codres@windriver.com>
Subject: [PATCH] dmaengine: idxd: fix use-after-free in idxd_free() and idxd_alloc() error paths
Date: Mon, 15 Jun 2026 13:39:32 +0300
Message-ID: <20260615103932.61828-2-bogdan.codres@windriver.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615103932.61828-1-bogdan.codres@windriver.com>
References: <20260615103932.61828-1-bogdan.codres@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0053.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::42) To BYAPR11MB3606.namprd11.prod.outlook.com
 (2603:10b6:a03:b5::25)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3606:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b7357a-d6ed-49aa-cd9d-08decaca76e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|23010399003|376014|18002099003|22082099003|38350700014|56012099006|5023799004|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jFnH+uY6cgGiESWAwDiA4F9KzgIcu07h4NREQHIMnK8zDbD2ZPQATV69WuFY4t3pZASg4dBiyp+rJZxoDj1r6vvLBa2tffVNAIxGSbxnu27gd9ebQEEn/yNTHb1lRaU4yfUAHnqKta2tzIMwjpjQQVl56SZtPWmBNa3pw37wPlxnl5GYwxAldnhRyXLex5I8IlFMtLjlFaZUwK6FcR7Z+Xy7UHhbP9JfPzHdK3YA568tBwq6RaMYuq9/uuFmHUSqnJrHbOxRQu6Ilp+qw/4jl01r/Wc9IutQzqMJdvJxecJy32x6FntdCsO9wYLCz3VBTi0VEMvWoMoKh079PDWSEgN6WLbJWSY9uJYBJByupwayHtkC55JTWrOOBGHaT2bcEth1yaCe8YlJSAHs/dA59W1ppSVIm3m4Xd4+TICs8hEK0bGXIcWvbFz/3Q5bF1Xkmthq/60hVRmhMqUsUTN/Btv6WRwbf0Gva4BksVHSS1JoYdjY2KPHF1JbMxx9rrtjAK+k1XBLz1Ig5ImfDccCALsSk6Ne6TxO6xihzQjrYyb7IWCwaeWNwjZcITn0F5uDrDkJOmrvRfnXENOGWDpIQIB2wHl2FeXu2yyHgdYA7rKb3QW/MrIT110AEkrScDHtgGQCJiH09OrZf5uc9p9AUWTPrKeevow3jV0rMC93Q/I59I088Z9HiayFKeFN2+cav/rXwE0cBMI12+h+Hk1zV7leanuNrQuRjnVIA/yhN8oUSHNkLRrgkmgO/XTLqK8y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3606.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(23010399003)(376014)(18002099003)(22082099003)(38350700014)(56012099006)(5023799004)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JU+F3hDBWqbc6eV6GUo6cvSXB3/cXG808qRWo531pVGu6lMppreIFsgKbVwF?=
 =?us-ascii?Q?s9jWIYpLeZFvIAdbd2cE1EtI5xtIuPCQFb8v1m2VOoA8iVfbwAg4vK/yWDtd?=
 =?us-ascii?Q?aSgZWcOitfrIhBaN+BE7c5AdojYbRbmhOFTU+4OY0iuMS9Sv4d+wSlK3cDRc?=
 =?us-ascii?Q?mPPb8DRq/1qK2CDLtHN7U7hYnFJ6Lmb8sAXyN3WBZjzu9CIcVaX6rspUTLZF?=
 =?us-ascii?Q?0J5Y4rkknW7gF56brI/akZqNLvnLhe2FQUI5haAA01YnFDgApcroyPB4epI7?=
 =?us-ascii?Q?YJO8Dygma1rbPw5+kLZhoKziW783zngzfJ/Dwx/ek4RNFaBFXaVObygNkZ69?=
 =?us-ascii?Q?2dWVAQJsqEjfeuZzDIozi2hFVn1A+qXVmwi1UuAeTslz73tcVCfbdxGFkd6c?=
 =?us-ascii?Q?rc7EbBd4ivBsYtgt/JGRnwWfaGsM28IW3GfVN5k8d9nj8zEvWxy98LjaMV5V?=
 =?us-ascii?Q?YSg6c63hECaJEbcIfGTlXiesndvOoDdxaC0Lez7e68L8efbJrNu4IHPKRbJQ?=
 =?us-ascii?Q?NWAhptNWEdedzEeVqFBimAiaoHobxSHSLmphxLjPpDCrb3DIWh+gJO358nFi?=
 =?us-ascii?Q?JZNNbkUseV3WwPtX1xyF/OAV0HRKue69CNLTRStbDFn42qNrLcvpcpW6Lecw?=
 =?us-ascii?Q?DmSK+yG1G7XGgGHtA0kXUIqFyfyPB9Xm+HMsBV7dkCoPO6m5gqTHlKP54oTW?=
 =?us-ascii?Q?LdSA33P59UuOcHkolvtlI4AAsoD8V9Va1bQ3rV1EMTbOlx+IhyYw3XAIlefq?=
 =?us-ascii?Q?fh9MMmQbAfx9Iz3aszNoUBpJiGNCxSqLFdcue9nUMpAOhwErvkAkX0DWrBlV?=
 =?us-ascii?Q?p46aroWVHG3u6w+kvJL6AM8Slu5dgskA1JmGLUTlLIBbUsi/GjgsMTUWH7sJ?=
 =?us-ascii?Q?lwDrwWVErrW71ZuABjdENvAU6tre3bjwVraPnt9qqnt/3XLILkaZ3684Q727?=
 =?us-ascii?Q?OBANv6ApO6iHtGblAe1Q5dwQumfaFr+ctyPLjt5Uhja3ulM5/OFotR7dttt0?=
 =?us-ascii?Q?WzYH1i9rsmBJgKk73xtMt4iYu5hoJ+Llgo47icZs02R6xNVBJHy7Mt1c+jx/?=
 =?us-ascii?Q?HzkSxku99ZJiVqOtrQ4ue5ilaSX/mD0PaomDeKLIIWE68b0UIS1Mtr/cYRen?=
 =?us-ascii?Q?WVi6Ygn+KnG75WfGuQ12TfxbPovzz5TGYHunE0OWWYsXIXDuikYm7tGYS874?=
 =?us-ascii?Q?QQg6ECW9JVik8/gChQvQMy/X8X3wTu0/sgar43MgDZxauL/TZ71ddXRmcHKj?=
 =?us-ascii?Q?Rq2UIFZuCwxhsvYP1dYUvuD9NBaMCR/MMHU5HS97AoAIEDIoF58TDYH/mpEo?=
 =?us-ascii?Q?JD0Y0OvXxM1VYkUuMpWDNZy11TKxPUI12ibOMYuwRGAP6P4iT2KPKnY6vMLX?=
 =?us-ascii?Q?jhmOZOK2+gXSTUokWA2nYqJ60dBRt0LXLmwlzei6su5XT+XukKCLWKFD9O4i?=
 =?us-ascii?Q?WXkn530/1XacrzrjbLjdOE9OqWAHHrMaJtLGyUmh0c56PHk15k7Os5YmjFmA?=
 =?us-ascii?Q?KG5qNTC9lj6W5BJ+cK3QclhHGDNAHJhdxZ+uVdmvPGCHP0rhMzArow0SBxpH?=
 =?us-ascii?Q?805Z6dgUb1QA2E3Ws8rVMF9jWXcpcPC14KOy5DmYKa3Kyrta/lJWm0kJQ0Gi?=
 =?us-ascii?Q?8Ks+Xgh8/A7+F1lcyy5e0KwhGv2J50JbLvLG0PahbNE8QLw2g2rEjuFQkjcV?=
 =?us-ascii?Q?KmGj4Huy3nmoJc+0EyYAyr+jEl3S7meI3AXo7dNClw6sqxhyZTSuvpbK/tim?=
 =?us-ascii?Q?rbPTZL7HFWldTNDavoogay2yQ84cD6g=3D?=
X-Exchange-RoutingPolicyChecked:
	JbFBIuFMesVUmmkh63BTAAjR81GvLMmO7jn6f8aOnxhEicN9wUUmLPPWcSXB2bs9JocJf3YbQli+GfGm7aHmEQyTGegQC0zSRNvqFe99SFpJUvCz9ASB17GJxCfGIa7q3VAOS73vNEWrC5IgXBmHKphFm3T3P5agGlpKguz1SddVvms8RK6NJrsfJE39/RZTtQcGaywnALK8Sco2x6PV8X78SAILZjpShgxZA+fig7Mi8EfgJUk07edjEyTnbAJ/rxHrEiOT/eNe//7xG7lEPEUPPo2xN0pzlf1rtUWkDxB5kTjDXWJJWRF6//ZPjln6okw3Bo6oXUv/wOEsRw3ldA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b7357a-d6ed-49aa-cd9d-08decaca76e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3606.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:40:06.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vncCZYYY8NbhhsruYrvAgBA8ovDsehjwYHJPDATeDqPoYD0rXxLPQk1H7+/tEJGLQ5OnRvlBDTtgrv6jyFQQxxZj45EA74MZRjmJZH4KvsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-Authority-Analysis: v=2.4 cv=SvmgLvO0 c=1 sm=1 tr=0 ts=6a2fd689 cx=c_pps
 a=3V8RUmgbnuIO8ORuzDaQ6A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8
 a=KKAkSRfTAAAA:8 a=1XspbSzA1Awqjsno4V4A:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9Y6NQfkIMPWSdCd09KaVZXKqNQG0kh1I
X-Proofpoint-ORIG-GUID: 9Y6NQfkIMPWSdCd09KaVZXKqNQG0kh1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX8HzcBQNM0Unj
 N/3968Ef5XexkLZ8w2surfnK9MzqcPPIgHoZBRA1W3j0+zwPFCiAK/ECFLoaghyOUPaOZL5waOL
 2lTqpx2bDc2gy8m6eoViOVUidr8Jt7Em1egGOfEyXFiHSe3uoMmmh+Qn2991h0Bq2cTm1iiaKXt
 OBaPyBQraZE9p0ol16u9CoZRagv2/s1i+NE1hwwur0EEZTB/R3vAlLuOIK+DrSZ+ccV+lINWGKR
 8UsC9ZxZVKvWecml49otd09oRJltfGKjDxqpiidgwBD+yPYXIlSxXmDVJbhZBWzWAwTEadQozK2
 IehYwelP/KgtkuIOl6GbpRvM0+Wdse1ZG5ow8jvj0DBLq0Gv0sx8nHJ/QIW/5wcHnrrFeiMApgC
 N3TIWm893KLfrC44qjeTAk8nD0pCmG0rP6EqZd5t/7KvawLUmbtl2VfeeIHJ+kSol9PPCa5WLjJ
 c/a1fBCMp95OZquPyxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX+K2LNnUJY1dV
 nfF5kzQl/MwyKGF99w2DlmYyXh0T7j2PU5Zh6HBpYeiQjTCV2L3P7KhJdexGxLsyEoSMixr/Ofc
 8LZI2xf3ynGB0PtZYFig9TsPyUDvvXdD5PqhrVR4fL00IQzTGyYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11517-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,linaro.org:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B29D2685648

From: Bogdan Codres <bogdan.codres@windriver.com>

We have the following backtrace:
[   18.628791] idxd 0000:00:01.0: Device is HALTED!
[   18.631447] idxd 0000:00:01.0: Intel(R) IDXD DMA Engine init failed
[   18.631450] ------------[ cut here ]------------
[   18.631451] ida_free called for id=0 which is not allocated.
[   18.631462] WARNING: CPU: 0 PID: 11 at lib/idr.c:525 ida_free+0xd3/0x130
[   18.631467] Modules linked in: idxd(+) idxd_bus wmi zl3073x_spi regmap_spi zl3073x_i2c zl3073x i2c_mux_pca954x i2c_mux ipmi_si acpi_power_meter i2c_designware_platform i2c_designware_core acpi_ipmi ipmi_devintf ipmi_msghandler
[   18.631474] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.12.0-1-rt-amd64 #1  Debian 6.12.40-1.stx.140
[   18.631477] Hardware name: Dell Inc. PowerEdge XR8720t/0J91KV, BIOS 1.1.3 02/03/2026
[   18.631478] Workqueue: events work_for_cpu_fn
[   18.631480] RIP: 0010:ida_free+0xd3/0x130
[   18.631482] Code: 62 ff 31 f6 48 89 e7 e8 bb 1b 02 00 eb 5a 83 fb 3e 76 36 48 8b 3c 24 e8 ab 74 03 00 89 ee 48 c7 c7 70 d6 bd b4 e8 7d 1e 36 ff <0f> 0b 48 8b 44 24 38 65 48 2b 04 25 28 00 00 00 75 37 48 83 c4 40
[   18.631484] RSP: 0018:ff59485680267d58 EFLAGS: 00010282
[   18.631485] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb53064c8
[   18.631486] RDX: 0000000000020940 RSI: 0000000000000000 RDI: ffffffffb53365d0
[   18.631487] RBP: 0000000000000000 R08: 0000000000000000 R09: ff59485680267b40
[   18.631487] R10: ff59485680267b38 R11: ffffffffb5336508 R12: 0000000000000000
[   18.631488] R13: ff2c9dd3800730c8 R14: 0000000000000000 R15: ff2c9dd38385d800
[   18.631489] FS:  0000000000000000(0000) GS:ff2c9dd3fdc00000(0000) knlGS:0000000000000000
[   18.631490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.631491] CR2: 000055e2e7678098 CR3: 0000002003450005 CR4: 0000000000771ef0
[   18.631492] PKRU: 55555554
[   18.631492] Call Trace:
[   18.631494]  <TASK>
[   18.631495]  idxd_pci_probe+0x1b0/0x1860 [idxd]
[   18.631502]  ? set_next_entity+0xcb/0x1b0
[   18.631506]  local_pci_probe+0x43/0xa0
[   18.631508]  work_for_cpu_fn+0x13/0x20
[   18.631510]  process_one_work+0x179/0x390
[   18.631512]  worker_thread+0x237/0x340
[   18.631515]  ? __pfx_worker_thread+0x10/0x10
[   18.631517]  kthread+0xc6/0x100
[   18.631519]  ? __pfx_kthread+0x10/0x10
[   18.631520]  ret_from_fork+0x2d/0x50
[   18.631523]  ? __pfx_kthread+0x10/0x10
[   18.631524]  ret_from_fork_asm+0x1a/0x30
[   18.631526]  </TASK>
[   18.631527] ---[ end trace 0000000000000000 ]---

When an IDXD device probe fails (e.g., device is HALTED), the error
path in idxd_pci_probe() calls idxd_free() which performs:

  1. put_device(idxd_confdev(idxd))
  2. bitmap_free(idxd->opcap_bmap)
  3. ida_free(&idxd_ida, idxd->id)
  4. kfree(idxd)

However, since device_initialize() was already called in idxd_alloc(),
the conf_dev has a refcount of 1. The put_device() in step 1 drops
this to 0 and synchronously invokes idxd_conf_device_release() via:

  put_device() -> kobject_put() -> kobject_release() -> kobject_cleanup()
    -> device_release() -> dev->type->release -> idxd_conf_device_release()

idxd_conf_device_release() already performs:

  ida_free(&idxd_ida, idxd->id);
  bitmap_free(idxd->opcap_bmap);
  kfree(idxd);

Therefore steps 2-4 in idxd_free() operate on already-freed memory:
  - step 2: bitmap_free on dangling pointer (use-after-free)
  - step 3: ida_free on already-released ID, triggering:
    "ida_free called for id=0 which is not allocated"
  - step 4: double kfree() corrupts slab freelist metadata

This is consistent with the pattern established in commit
c311f5e9248471a950 ("dmaengine: idxd: Fix freeing the allocated ida
too late") where ida_free() was removed from the cdev .release()
callback because resources must not be freed in both the .release()
callback and the caller of put_device().

The path is extremely rare in normal operation because:
  1. IDXD probe only fails when the device is in HALTED state
  2. The device enters HALTED state exclusively after reset_devices
     (kdump boot parameter) or unrecoverable hardware error
  3. On a normally running system, IDXD probe always succeeds

Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
Cc: stable@vger.kernel.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Yi Sun <yi.sun@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Bogdan Codres <bogdan.codres@windriver.com>
---
 drivers/dma/idxd/init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e55136bb5..b76f0d12b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -586,15 +586,18 @@ static void idxd_read_caps(struct idxd_device *idxd)
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
@@ -634,13 +637,16 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
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
 	kfree(idxd);
-
 	return NULL;
 }
 
-- 
2.43.0


